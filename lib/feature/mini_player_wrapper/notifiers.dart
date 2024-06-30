import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';

final showMiniPlayerProvider = StreamProvider<bool>((ref)  {
  final playerService = GetIt.I.get<AudioPlayerService>();
  return playerService.showMiniplayer;
});

final playerStateProvider = StreamProvider<PlayerState>((ref) {
  final playerService = GetIt.I.get<AudioPlayerService>();
  return playerService.playstateStream;
});

final durationProvider = StreamProvider<(Duration, Duration)>((ref) {
  final playerService = GetIt.I.get<AudioPlayerService>();
  return Rx.combineLatest2(
    playerService.audioDurationStream,
    playerService.positionStream,
    (a, b) {
      return (a, b);
    },
  );
});

final positionProvider = StreamProvider<Duration>((ref) {
  final playerService = GetIt.I.get<AudioPlayerService>();
  return playerService.positionStream;
});