import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerService {
  final audioPlayer = AudioPlayer();

  BehaviorSubject<bool> showMiniplayer = BehaviorSubject.seeded(false);

  Future<Duration> play(String path) async {
    try {
      final duration = await audioPlayer.setAudioSource(AudioSource.file(path));
      showMiniplayer.add(true);
      audioPlayer.play();
      return duration ?? Duration.zero;
    } catch (e) {
      return Duration.zero;
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    showMiniplayer.add(false);
    audioPlayer.stop();
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  Stream<PlayerState> get playstateStream => audioPlayer.playerStateStream;
  Stream<Duration> get positionStream => audioPlayer.positionStream;
  Stream<Duration> get audioDurationStream => audioPlayer.durationStream.map(
        (event) => event ?? Duration.zero,
      );
}