import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch_app/features/data/models/marked_item_model.dart';
import 'package:stopwatch_app/features/presentation/manager/add_flags_cubit/add_flags_cubit.dart';
import 'package:stopwatch_app/features/presentation/views/widgets/flagged_item_listview.dart';

import '../../manager/flagged_cubit.dart';

class StopwatchViewBody extends StatefulWidget {
  const StopwatchViewBody({super.key});

  @override
  State<StopwatchViewBody> createState() => _StopwatchViewBodyState();
}

class _StopwatchViewBodyState extends State<StopwatchViewBody> {
  late Stopwatch stopwatch;
  late Timer timer;
  bool isPlay = false;
  Duration? lastMarkedTime;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      isPlay = false;
    } else {
      stopwatch.start();
      isPlay = true;
    }
  }

  String formattedText(Duration duration) {
    var milli = duration.inMilliseconds;
    String milliseconds = (milli % 100).toString().padLeft(2, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(const Duration(milliseconds: 30), (t) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "StopWatch",
          style: TextStyle(color: Color(0xff0a697a)),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AddFlagsCubit, AddFlagsState>(
        listener: (context, state) {
          if (state is AddFlagsSuccessState) {
            BlocProvider.of<FlaggedCubit>(context).fetchFlags();
          }
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xff0a697a),
                  width: 4,
                ),
              ),
              child: Text(formattedText(stopwatch.elapsed)),
            ),
            const FlaggedItemListView(),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  decoration: const ShapeDecoration(
                      color: Color(0xff0a697a),
                      shape: RoundedRectangleBorder()),
                  child: IconButton(
                      onPressed: () {
                        stopwatch = Stopwatch();
                        isPlay = false;
                        lastMarkedTime = null;
                        int flagsNum = BlocProvider.of<FlaggedCubit>(context)
                                .flags
                                ?.length ??
                            0;
                        for (var i = 0; i < flagsNum; i++) {
                          BlocProvider.of<FlaggedCubit>(context)
                              .flags?[i]
                              .delete()
                              .then((value) {
                            BlocProvider.of<FlaggedCubit>(context).fetchFlags();
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.restart_alt,
                        color: Colors.white,
                      )),
                )),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  decoration: const ShapeDecoration(
                      color: Color(0xff0a697a),
                      shape: RoundedRectangleBorder()),
                  child: IconButton(
                      onPressed: () {
                        handleStartStop();
                        var time = formattedText(stopwatch.elapsed);
                        print(time);
                      },
                      icon: isPlay
                          ? const Icon(
                              Icons.pause,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            )),
                )),
                Expanded(
                    child: Container(
                  decoration: const ShapeDecoration(
                      color: Color(0xff0a697a),
                      shape: RoundedRectangleBorder()),
                  child: IconButton(
                      onPressed: () {
                        var currentTime = stopwatch.elapsed;
                        var formattedCurrentTime = formattedText(currentTime);
                        print(formattedCurrentTime);

                        var flags =
                            BlocProvider.of<FlaggedCubit>(context).flags ?? [];
                        if (isPlay == true) {
                          if (flags.isEmpty) {
                            BlocProvider.of<AddFlagsCubit>(context).addFlags(
                                MarkedItemModel(
                                    differenceTime: formattedCurrentTime,
                                    finalTime: formattedCurrentTime,
                                    num: 1));
                          } else {
                            var differenceTime = lastMarkedTime == null
                                ? formattedCurrentTime
                                : formattedText(currentTime - lastMarkedTime!);
                            print(differenceTime);

                            int num = 0;
                            for (int counter = 0;
                                counter <= flags.length;
                                counter++) {
                              num = num + 1;
                            }

                            BlocProvider.of<AddFlagsCubit>(context).addFlags(
                                MarkedItemModel(
                                    differenceTime: differenceTime,
                                    finalTime: formattedCurrentTime,
                                    num: num));
                          }
                          lastMarkedTime = currentTime;
                        }
                      },
                      icon: const Icon(
                        Icons.flag,
                        color: Colors.white,
                      )),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
