import 'dart:async';

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voice_notes/core/utils/constants.dart';

class AudioRecorderService {
  final _timerService = AudioRecordDurationService();
  final _recorder = AudioRecorder();

  late String path;

  Stream<int> get timerSteam => _timerService.timerStream.stream;

  Future<void> initialize() async {
    path = (await getApplicationDocumentsDirectory()).path;
  }

  void startRecording() {
    /// Add one permission check here otherwise only timer will start whereas actual recording is yet to start
    _recorder.start(const RecordConfig(androidConfig: AndroidRecordConfig()),
        path: "$path${AppConstants.defaultPath}");
    _timerService.startTimer();
  }

  ({int duration, String path}) stopRecording() {
    _recorder.stop();
    return (
      duration: _timerService.stopTimer(),
      path: "$path${AppConstants.defaultPath}"
    );
  }

  void pauseRecording() async {
    _recorder.pause();
    _timerService.pauseTimer();
  }

  void resumeRecording() async {
    _recorder.resume();
    _timerService.resumeTimer();
  }

  void dispose() {
    _recorder.dispose();
  }
}

class AudioRecordDurationService {
  int _recordDuration = 0;

  final BehaviorSubject<int> timerStream = BehaviorSubject.seeded(0);

  Timer? timer;

  void startTimer() {
    timerStream.add(_recordDuration);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordDuration += 1;
      timerStream.add(_recordDuration);
    });
  }

  int stopTimer() {
    timer?.cancel();
    final oldDuration = _recordDuration;
    _recordDuration = 0;
    return oldDuration;
  }

  void pauseTimer() {
    timer?.cancel();
  }

  void resumeTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordDuration += 1;
      timerStream.add(_recordDuration);
    });
  }
}
