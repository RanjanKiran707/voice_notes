import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/core/services/shared_preference_service.dart';
import 'package:voice_notes/core/services/sync_service.dart';
import 'package:voice_notes/core/utils/constants.dart';

class Dep {
  static AudioRecorderService get audioRecord =>
      GetIt.I.get<AudioRecorderService>();
  static AudioPlayerService get player => GetIt.I.get<AudioPlayerService>();

  static SyncService get sync => GetIt.I.get<SyncService>();

  static Realm get atlas => GetIt.I.get<Realm>(
        instanceName: AppConstants.atlas,
      );
  static Realm get local => GetIt.I.get<Realm>(
        instanceName: AppConstants.local,
      );
  static SharedPreferenceService get prefService =>
      GetIt.I.get<SharedPreferenceService>();
}
