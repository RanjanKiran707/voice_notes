import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:voice_notes/core/services/audio_player_service.dart';
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
                                  final position = data.$2.inMilliseconds;
                                  final total = data.$1.inMilliseconds;
                                  final value =
                                      total == 0 ? 0 : position / total;
                                  final showinVal =
                                      clampDouble(value.toDouble(), 0, 1);
                                  debugPrint("Value = $value");
                                  debugPrint("Showing Val = $showinVal");
                                  debugPrint("Position = ${position}");
                                  return Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(false
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                        color: Colors.white,
                                        onPressed: (){},
                                      ),
                                      Expanded(
                                        child: Slider(
                                          value: showinVal,
                                          min: 0.0,
                                          max: 1,
                                          activeColor: Colors.red,
                                          inactiveColor: Colors.white,
                                          onChanged: (value) {
                                            // setState(() {
                                            //   currentSliderValue = value;
                                            // });
                                          },
                                        ),
                                      ),
                                      Text(
                                        "${showinVal.toStringAsFixed(0)}%",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        icon: Icon(Icons.skip_next),
                                        color: Colors.white,
                                        onPressed: () {
                                          // Handle skip next
                                        },
                                      ),
                                    ],
                                  );

                                  return Slider(
                                    value: showinVal,
                                    onChanged: (val) {},
                                  );
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
                    }else{
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
