import 'dart:ui';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:voice_notes/core/extension_utils.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/dependency_service.dart';
import 'package:voice_notes/feature/mini_player_wrapper/notifiers.dart';
import 'package:voice_notes/feature/subject_list/subject_list_view.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MiniPlayerWrapper extends StatelessWidget {
  const MiniPlayerWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MiniplayerWillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = _navigatorKey.currentState!;
        if (!navigator.canPop()) return true;
        navigator.pop();

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Navigator(
              key: _navigatorKey,
              onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => SubjectListView(),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final show = ref.watch(showMiniPlayerProvider);
                return show.when(
                  data: (data) {
                    if (data) {
                      return Miniplayer(
                        minHeight: 60,
                        maxHeight: 370,
                        builder: (height, percentage) => Center(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final duration = ref.watch(durationProvider);

                              return duration.when(
                                data: (data) {
                                  final position = clampDouble(
                                      data.$2.inMilliseconds.toDouble(),
                                      0,
                                      data.$1.inMilliseconds.toDouble());
                                  final total = data.$1.inMilliseconds;

                                  return Container(
                                    padding: EdgeInsets.all(12),
                                    color: Colors.blueAccent,
                                    child: Row(
                                      children: [
                                        StreamBuilder(
                                          stream: Dep.player.playstateStream,
                                          builder: (context, snapshot) {
                                            final data = snapshot.data ??
                                                PlayerState(false,
                                                    ProcessingState.idle);
                                            if (data.processingState ==
                                                ProcessingState.completed) {
                                              return IconButton(
                                                icon: Icon(Icons.replay),
                                                color: Colors.white,
                                                onPressed: () {
                                                  Dep.player.replay();
                                                },
                                              );
                                            }
                                            return IconButton(
                                              icon: Icon(data.playing
                                                  ? Icons.pause
                                                  : Icons.play_arrow),
                                              color: Colors.white,
                                              onPressed: () {
                                                if (data.playing) {
                                                  Dep.player.pause();
                                                } else {
                                                  Dep.player.resume();
                                                }
                                              },
                                            );
                                          },
                                        ),
                                        Expanded(
                                          child: Slider(
                                            value: position.toDouble(),
                                            min: 0,
                                            max: total.toDouble(),
                                            activeColor: Colors.red,
                                            inactiveColor: Colors.white,
                                            onChanged: (value) {
                                              Dep.player.seekToMiliSec(value);
                                            },
                                          ),
                                        ),
                                        Text(
                                          "${data.$2.format}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          color: Colors.white,
                                          onPressed: () {
                                            final service = GetIt.I
                                                .get<AudioPlayerService>();

                                            service.stop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );

                                  // return Slider(
                                  //   value: showinVal,
                                  //   onChanged: (val) {},
                                  // );
                                },
                                error: (error, stackTrace) {
                                  return SizedBox();
                                },
                                loading: () {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                  error: (error, stackTrace) {
                    return SizedBox();
                  },
                  loading: () {
                    return SizedBox();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
