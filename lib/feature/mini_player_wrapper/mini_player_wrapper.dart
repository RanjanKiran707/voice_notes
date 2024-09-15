import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:voice_notes/core/extension_utils.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
import 'package:voice_notes/core/services/dependency_service.dart';
import 'package:voice_notes/domain/database.dart';
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
                builder: (BuildContext context) => const SubjectListView(),
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

                                  if (percentage <= 0.25) {
                                    return Container(
                                      padding: const EdgeInsets.all(12),
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
                                                  icon:
                                                      const Icon(Icons.replay),
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
                                            data.$2.format,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: const Icon(Icons.close),
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
                                  }

                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    color: Colors.blueAccent,
                                    child: Column(
                                      children: [
                                        _buildTitle(),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Slider(
                                                value: position.toDouble(),
                                                min: 0,
                                                max: total.toDouble(),
                                                activeColor: Colors.red,
                                                inactiveColor: Colors.white,
                                                onChanged: (value) {
                                                  Dep.player
                                                      .seekToMiliSec(value);
                                                },
                                              ),
                                            ),
                                            Text(
                                              data.$2.format,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(width: 10),
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              color: Colors.white,
                                              onPressed: () {
                                                final service = GetIt.I
                                                    .get<AudioPlayerService>();

                                                service.stop();
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  Dep.player.goPrevious();
                                                },
                                                icon: const Icon(
                                                    Icons.skip_previous)),
                                            StreamBuilder(
                                              stream:
                                                  Dep.player.playstateStream,
                                              builder: (context, snapshot) {
                                                final data = snapshot.data ??
                                                    PlayerState(false,
                                                        ProcessingState.idle);
                                                if (data.processingState ==
                                                    ProcessingState.completed) {
                                                  return IconButton(
                                                    icon: const Icon(
                                                        Icons.replay),
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
                                            IconButton(
                                                color: Colors.white,
                                                onPressed: () {
                                                  Dep.player.goNext();
                                                },
                                                icon: const Icon(
                                                    Icons.skip_next)),
                                          ],
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
                                  return const SizedBox();
                                },
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  error: (error, stackTrace) {
                    return const SizedBox();
                  },
                  loading: () {
                    return const SizedBox();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return StreamBuilder(
      stream: Dep.player.audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null) {
          return const Text("Loading..");
        }

        return Text(
          (data.currentSource?.tag as Topic?)?.name ?? "No name",
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
