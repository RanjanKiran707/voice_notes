import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/core/services/logging_service.dart';
import 'package:voice_notes/core/services/shared_preference_service.dart';
import 'package:voice_notes/core/services/sync_service.dart';
import 'package:voice_notes/core/utils/constants.dart';
import 'package:voice_notes/domain/database.dart';

final appConfig = AppConfiguration("application-0-puzib");
final app = App(appConfig);

Future<void> inject() async {
  final recorderService = AudioRecorderService();
  await recorderService.initialize();
  GetIt.I.registerSingleton(recorderService);

  GetIt.I.registerSingleton(AudioPlayerService());

  final instance = SharedPreferenceService();

  await instance.initialize();
  GetIt.I.registerSingleton(instance);

  LogService.instance.i("Injected all dpendencies");
}

Future<void> injectRealmDependency() async {
  // final token = await user.getIdToken();
  // final realmUser = await app.logIn(Credentials.jwt(token ?? ""));
  final realm = Realm(
      Configuration.local([Subject.schema, Chapter.schema, Topic.schema]));

  // realm.subscriptions.update(
  //   (mutableSubscriptions) {
  //     mutableSubscriptions.add(realm.all<Subject>());
  //   },
  // );
  GetIt.I.registerSingleton(
    realm,
    instanceName: AppConstants.local,
    dispose: (param) {
      param.close();
    },
  );

  // final localRealm = Realm(Configuration.local([LocalVoiceNote.schema]));
  // GetIt.I.registerSingleton(
  //   localRealm,
  //   instanceName: AppConstants.local,
  //   dispose: (param) {
  //     param.close();
  //   },
  // );

  GetIt.I.registerSingleton(SyncService(
    atlasRealm: GetIt.I.get(instanceName: AppConstants.local),
    // localRealm: GetIt.I.get(instanceName: AppConstants.local),
  ));
}
