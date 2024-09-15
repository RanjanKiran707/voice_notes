import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/core/services/logging_service.dart';
import 'package:voice_notes/core/utils/constants.dart';
import 'package:voice_notes/core/widgets/add_dialog.dart';
import 'package:voice_notes/core/widgets/common_app_bar.dart';
import 'package:voice_notes/core/widgets/confirm_dialog.dart';
import 'package:voice_notes/domain/database.dart';
import 'package:voice_notes/feature/topic_list/notifiers/topic_list_notifier.dart';
import 'package:voice_notes/feature/topic_list/widgets/record_bottom_sheet_helper.dart';

class TopicListView extends ConsumerWidget {
  TopicListView({super.key, required this.chapter});
  final Chapter chapter;
  final realm = GetIt.I.get<Realm>(
    instanceName: AppConstants.local,
  );
  final recordService = GetIt.I.get<AudioRecorderService>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        title: chapter.name,
        onAddPress: () async {
          _addNewTopic(context);
        },
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final topics = ref.watch(topicListNotifierProvider(chapter));
          return topics.when(
            data: (data) {
              final topicList = data.list;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(topicList[index].name),
                    trailing: IconButton(
                      onPressed: () {
                        final service = GetIt.I.get<AudioPlayerService>();

                        service.playList(topicList, index);
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        ConfirmDialog.show(
                          context: context,
                          title: "Delete topic",
                          content:
                              "Are you sure you want to delete ${topicList[index].name}",
                          onConfirm: () {
                            realm.writeAsync(() {
                              realm.delete(topicList[index]);
                            });
                            try {
                              final file =
                                  File(topicList[index].voiceLocalPath ?? "");
                              file.delete();
                              LogService.instance
                                  .i("Successfully deleted file of voice note");
                            } catch (e) {
                              LogService.instance
                                  .e("Error deleting voice note file $e");
                            }
                          },
                          onDismiss: () {},
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
                itemCount: topicList.length,
              );
            },
            error: (error, stackTrace) {
              return const Center();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }

  String _renameFile(String path, String newName) {
    final File file = File(path);

    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newName;

    file.rename(newPath);
    return newPath;
  }

  void _addNewTopic(BuildContext context) async {
    if (!(await _micPermission())) {
      return;
    }
    final ans = await RecordBottomSheet.showRecordBottomsheet(context);

    if (ans != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AddDialog(
            hintText: "Enter topic name",
            onSubmit: ({required name}) {
              final localPath = "$name${Random().nextInt(100000)}.m4a";
              String newName = _renameFile(ans.path, localPath);
              realm.write(() {
                chapter.topics.add(
                  Topic(ObjectId(), name, "", voiceLocalPath: newName),
                );
              });

              // Dep.sync.uploadPendingTopics();
            },
          );
        },
      );
    }
  }

  Future<bool> _micPermission() async {
    if (await Permission.microphone.isGranted) {
      return true;
    } else {
      final result = await Permission.microphone.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
