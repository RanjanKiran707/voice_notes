import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/nav_utils.dart';
import 'package:voice_notes/core/widgets/add_dialog.dart';
import 'package:voice_notes/domain/database.dart';
import 'package:voice_notes/feature/chapter_list/notifiers/chapter_list_notifier.dart';
import 'package:voice_notes/feature/subject_list/notifiers/subjects_notifier.dart';
import 'package:voice_notes/feature/topic_list/topic_list_view.dart';

class ChapterListView extends ConsumerWidget{
  ChapterListView({super.key, required this.subject});
  final Subject subject;
  final realm = GetIt.I.get<Realm>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          
          final chapterValue = ref.watch(chapterListNotifierProvider(subject));
          return chapterValue.when(
            data: (data) {
              final chapterList = data.list;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chapterList[index].name),
                    onTap: (){
                       NavUtils.push(
                        context,
                        TopicListView(
                          chapter: chapterList[index],
                        ),
                      );
                    },
                  );
                },
                itemCount: chapterList.length,
              );
            },
            error: (error, stackTrace) {
              return Center();
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           showDialog(
            context: context,
            builder: (context) {
              return AddDialog(
                hintText: "Enter chapter name",
                onSubmit: ({required name}) {
                  final realm = GetIt.I.get<Realm>();
                  realm.write(() {
                    subject.chapters.add(
                        Chapter(ObjectId(), name));
                  });
                },
              );
            },
          );
        },
        label: Text("Add chapter"),
        icon: Icon(Icons.add),
      ),
    );
  }
}


