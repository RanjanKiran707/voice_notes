import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/nav_utils.dart';
import 'package:voice_notes/core/widgets/add_dialog.dart';
import 'package:voice_notes/domain/database.dart';
import 'package:voice_notes/feature/chapter_list/chapter_list_view.dart';
import 'package:voice_notes/feature/subject_list/notifiers/subjects_notifier.dart';

class SubjectListView extends ConsumerWidget {
  SubjectListView({super.key});
  final realm = GetIt.I.get<Realm>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final subjects = ref.watch(subjectsProvider);
          return subjects.when(
            data: (data) {
              final subjectList = data.results.toList();
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(subjectList[index].name),
                    onTap: (){
                      NavUtils.push(
                        context,
                        ChapterListView(
                          subject: subjectList[index],
                        ),
                      );
                    },
                  );
                },
                itemCount: subjectList.length,
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
                hintText: "Enter subject name",
                onSubmit: ({required name}) {
                  realm.write(() {
                    realm.add<Subject>(Subject(ObjectId(), name));
                  });
                },
              );
            },
          );
        },
        label: Text("Add subject"),
        icon: Icon(Icons.add),
      ),
    );
  }
}


