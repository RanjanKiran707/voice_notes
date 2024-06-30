import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:riverpod/riverpod.dart';
import 'package:voice_notes/domain/database.dart';

class SubjectsNotifier extends StreamNotifier<RealmResultsChanges<Subject>> {
  @override
  Stream<RealmResultsChanges<Subject>> build() {
    final realm = GetIt.I.get<Realm>();
    return realm.all<Subject>().changes;
  }
}

final subjectsProvider = StreamNotifierProvider<SubjectsNotifier, RealmResultsChanges<Subject>>(SubjectsNotifier.new);