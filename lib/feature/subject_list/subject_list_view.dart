import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/nav_utils.dart';
import 'package:voice_notes/core/utils/constants.dart';
import 'package:voice_notes/core/widgets/add_dialog.dart';
import 'package:voice_notes/core/widgets/common_app_bar.dart';
import 'package:voice_notes/domain/database.dart';
import 'package:voice_notes/feature/chapter_list/chapter_list_view.dart';
import 'package:voice_notes/feature/subject_list/notifiers/inject_realm_notifier.dart';
import 'package:voice_notes/feature/subject_list/notifiers/subjects_notifier.dart';
import 'package:voice_notes/injection.dart';

class SubjectListView extends ConsumerWidget {
  SubjectListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loader = ref.watch(realmInitProvider);

    return loader.when(
      data: (data) {
        final realm = GetIt.I.get<Realm>(
          instanceName: AppConstants.local,
        );
        return Scaffold(
          appBar: CommonAppBar(
            title: "Subjects",
            onAddPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddDialog(
                    hintText: "Enter subject name",
                    onSubmit: ({required name}) {
                      realm.write(() {
                        realm.add<Subject>(
                            Subject(ObjectId(), name, app.currentUser!.id));
                      });
                    },
                  );
                },
              );
            },
          ),
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
                        onTap: () {
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
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text("Error logging in $error"),
          ),
        );
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
