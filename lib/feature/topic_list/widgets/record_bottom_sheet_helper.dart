import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:voice_notes/core/services/audio_recorder_service.dart';
import 'package:voice_notes/feature/topic_list/widgets/record_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class RecordBottomSheet {
  static ValueNotifier<int> indexNotifier = ValueNotifier(0);

  static Future<({int duration, String path})?> showRecordBottomsheet(
      BuildContext context) {
    return WoltModalSheet.show<({int duration, String path})>(
      context: context,
      pageIndexNotifier: indexNotifier,
      barrierDismissible: false,
      pageListBuilder: (context) {
        return [
          RecordBottomSheet.buildRecordPage(context),
          RecordBottomSheet.buildTimerPage(context),
        ];
      },
    );
  }

  static buildRecordPage(BuildContext context) {
    return WoltModalSheetPage(
      hasTopBarLayer: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Center(
          child: FilledButton.tonalIcon(
            onPressed: () {
              indexNotifier.value = 1;
              GetIt.I.get<AudioRecorderService>().startRecording();
            },
            label: Text("Start recording"),
            icon: Icon(Icons.mic),
          ),
        ),
      ),
    );
  }

  static buildTimerPage(BuildContext context) {
    return WoltModalSheetPage(
      hasTopBarLayer: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: RecordBottomSheetWidget(),
      ),
    );
  }
}
