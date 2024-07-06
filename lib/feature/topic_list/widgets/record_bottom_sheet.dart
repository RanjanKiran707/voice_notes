import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/feature/topic_list/widgets/record_bottom_sheet_helper.dart';

final timerStreamProvider =
    StreamProvider.family<int, AudioRecorderService>((ref, args) {
  return args.timerSteam;
});

class RecordBottomSheetWidget extends ConsumerWidget {
  RecordBottomSheetWidget({super.key});

  final recordService = GetIt.I.get<AudioRecorderService>();

  bool isPaused = false;

  @override
  Widget build(BuildContext context, ref) {
    final timer = ref.watch(timerStreamProvider(recordService));
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          timer.when(
            data: (data) {
              final duration = Duration(seconds: data);
              String durationString =
                  '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
              return Text(
                durationString,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
            error: (error, stackTrace) {
              return const SizedBox();
            },
            loading: () {
              return const SizedBox();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              StatefulBuilder(builder: (context, stateSet) {
                return FilledButton.icon(
                  onPressed: () {
                    if (!isPaused) {
                      recordService.pauseRecording();
                    } else {
                      recordService.resumeRecording();
                    }
                    isPaused = !isPaused;
                    stateSet(() {});
                  },
                  icon: isPaused ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                  label: isPaused ? Text("Resume") : Text("Pause"),
                );
              }),
              FilledButton.icon(
                onPressed: () {
                  final result = recordService.stopRecording();
                  Navigator.pop(context, result);
                  RecordBottomSheet.indexNotifier.value = 0;
                },
                label: const Text("Stop recording"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
