import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/core/services/logging_service.dart';
import 'package:voice_notes/core/services/sync_service.dart';
import 'package:voice_notes/domain/database.dart';

Future<void> inject() async {
  await injectRealmDependency();
  final recorderService = AudioRecorderService();
  await recorderService.initialize();
  GetIt.I.registerSingleton(recorderService);

  GetIt.I.registerSingleton(SyncService(realm: GetIt.I.get()));
  GetIt.I.registerSingleton(AudioPlayerService());

  LogService.instance.i("Injected all dpendencies");
}

Future<void> injectRealmDependency() async {
  final appConfig = AppConfiguration("application-0-puzib");
  final app = App(appConfig);
  final user = await app.logIn(Credentials.anonymous());
  final realm = Realm(Configuration.flexibleSync(
      user, [Subject.schema, Chapter.schema, Topic.schema]));

  realm.subscriptions.update(
    (mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<Subject>());
    },
  );
  GetIt.I.registerSingleton(
    realm,
    dispose: (param) {
      param.close();
    },
  );
}
