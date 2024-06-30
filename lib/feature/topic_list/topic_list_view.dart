import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/core/widgets/add_dialog.dart';
import 'package:voice_notes/domain/database.dart';
import 'package:voice_notes/feature/chapter_list/notifiers/chapter_list_notifier.dart';
import 'package:voice_notes/feature/subject_list/notifiers/subjects_notifier.dart';
import 'package:voice_notes/feature/topic_list/notifiers/topic_list_notifier.dart';
import 'package:voice_notes/feature/topic_list/widgets/record_bottom_sheet_helper.dart';

class TopicListView extends ConsumerWidget {
  TopicListView({super.key, required this.chapter});
  final Chapter chapter;
  final realm = GetIt.I.get<Realm>();
  final recordService = GetIt.I.get<AudioRecorderService>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {          
          final topics = ref.watch(topicListNotifierProvider(chapter));
          return topics.when(
            data: (data) {
              final subjectList = data.list;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(subjectList[index].name),
                    trailing:  IconButton(
                      onPressed: () {
                        final service = GetIt.I.get<AudioPlayerService>();

                        service.stop();
                      },
                      icon: Icon(Icons.stop),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        final service = GetIt.I.get<AudioPlayerService>();

                        service.play(subjectList[index].voiceLocalPath ?? "");
                      },
                      icon: Icon(Icons.play_arrow),
                    ),
                  );
                },
                itemCount: subjectList.length,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{

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
                    String newName = _renameFile(ans.path,localPath);
                    realm.write(() {
                      chapter.topics.add(
                        Topic(ObjectId(), name, "", voiceLocalPath: newName),
                      );
                    });
                  },
                );
              },
            );
          }    
           

         

          // debugPrint("Done");
        },
        label: const Text("Add topic"),
        icon: const Icon(Icons.add),
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
}


