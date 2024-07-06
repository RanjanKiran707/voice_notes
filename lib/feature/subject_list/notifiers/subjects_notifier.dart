import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:riverpod/riverpod.dart';
import 'package:voice_notes/core/services/dependency_service.dart';
import 'package:voice_notes/core/services/logging_service.dart';
import 'package:voice_notes/core/utils/constants.dart';
import 'package:voice_notes/domain/database.dart';

class SubjectsNotifier
    extends AutoDisposeStreamNotifier<RealmResultsChanges<Subject>> {
  @override
  Stream<RealmResultsChanges<Subject>> build() {
    final realm = GetIt.I.get<Realm>(
      instanceName: AppConstants.local,
    );

    ref.onDispose(() {
      LogService.instance.i("Subjects Notifier is disposed");
    });
    return realm.all<Subject>().changes;
  }
}

final subjectsProvider = AutoDisposeStreamNotifierProvider<SubjectsNotifier,
    RealmResultsChanges<Subject>>(SubjectsNotifier.new);
