import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/services/logging_service.dart';
import 'package:voice_notes/domain/database.dart';
import 'package:path/path.dart' as path;

class SyncService {
  final Realm atlasRealm;
  // final Realm localRealm;

  SyncService({required this.atlasRealm});

  /// This will sync all pending topics
  Future<void> uploadPendingTopics() async {
    final pendings = <Topic>[];

    final subjects = atlasRealm.query<Subject>("chapters.@count > 0");

    for (var subject in subjects) {
      for (final chapter in subject.chapters) {
        for (final topic in chapter.topics) {
          if (topic.remoteUrl.isEmpty) {
            pendings.add(topic);
          }
        }
      }
    }
    LogService.instance
        .i("Length of pending recordings to be synced is ${pendings.length}");

    List<Future> uploads = [];
    for (final pending in pendings) {
      uploads.add(_uploadToStorage(pending));
    }
    await Future.wait(uploads);
  }

  // Future<void> downloadPending() async {
  //   final pendings = <Topic>[];

  //   final subjects = atlasRealm.query<Subject>("chapters.@count > 0");

  //   for (var subject in subjects) {
  //     for (final chapter in subject.chapters) {
  //       for (final topic in chapter.topics) {
  //         final topicID = topic.id;
  //         final results =
  //             // localRealm.query<LocalVoiceNote>("topicId == \$0", [topicID]);
  //         if (results.isEmpty) {
  //           pendings.add(topic);
  //         }
  //       }
  //     }
  //   }
  //   LogService.instance
  //       .i("Length of pending recordings to be synced is ${pendings.length}");

  //   List<Future> downloads = [];
  //   for (final pending in pendings) {
  //     downloads.add(_downloadToStorage(pending));
  //   }
  //   await Future.wait(downloads);
  // }

  Future<void> _uploadToStorage(Topic pending) async {
    if (pending.voiceLocalPath?.isEmpty ?? true) {
      return;
    }
    final File file = File(pending.voiceLocalPath ?? "");

    try {
      Reference ref = FirebaseStorage.instance.ref().child(
          "recordings/${FirebaseAuth.instance.currentUser?.email}/${path.basename(file.path)}");
      final task = ref.putFile(file);
      TaskSnapshot taskSnapshot = await task;

      // Get the download URL
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      atlasRealm.write(() {
        pending.remoteUrl = downloadUrl;
      });
      LogService.instance.i("Succesfully upload recording for ${pending.name}");
    } catch (e) {
      LogService.instance
          .i("Error in upload recording for ${pending.name} = ${e}");
    }
  }

  Future<void> _downloadToStorage(Topic pending) async {
    if (pending.remoteUrl.isEmpty) {
      return;
    }
    Reference ref = FirebaseStorage.instance.refFromURL(pending.remoteUrl);
  }
}
