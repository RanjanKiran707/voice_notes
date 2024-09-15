import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voice_notes/core/services/dependency_service.dart';
import 'package:voice_notes/domain/database.dart';

class AudioPlayerService {
  final audioPlayer = AudioPlayer();

  BehaviorSubject<bool> showMiniplayer = BehaviorSubject.seeded(false);

  Future<Duration> play(String path) async {
    try {
      final duration = await audioPlayer.setAudioSource(AudioSource.file(path));
      showMiniplayer.add(true);
      audioPlayer.play();

      audioPlayer.setSpeed(Dep.prefService.getSpeed());
      return duration ?? Duration.zero;
    } catch (e) {
      return Duration.zero;
    }
  }

  Future<Duration> playList(List<Topic> topics, int currentIndex) async {
    try {
      final source = ConcatenatingAudioSource(
          children: topics
              .map((element) =>
                  AudioSource.file(element.voiceLocalPath!, tag: element))
              .toList());
      final duration = await audioPlayer.setAudioSource(source,
          initialIndex: currentIndex, initialPosition: Duration.zero);
      showMiniplayer.add(true);
      audioPlayer.play();

      audioPlayer.setSpeed(Dep.prefService.getSpeed());
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

  void resume() {
    audioPlayer.play();
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  void seekToMiliSec(double milSecs) {
    audioPlayer.seek(Duration(milliseconds: milSecs.toInt()));
  }

  void replay() {
    audioPlayer.seek(Duration.zero);
    // audioPlayer.play();
  }

  void goNext() {
    audioPlayer.seekToNext();
  }

  void goPrevious() {
    audioPlayer.seekToPrevious();
  }

  Stream<PlayerState> get playstateStream => audioPlayer.playerStateStream;
  Stream<Duration> get positionStream => audioPlayer.positionStream;
  Stream<Duration> get audioDurationStream => audioPlayer.durationStream.map(
        (event) => event ?? Duration.zero,
      );
}
