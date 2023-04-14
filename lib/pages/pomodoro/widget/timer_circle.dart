import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';

class TimerCircle extends StatelessWidget {
  final MetasCubit cubit;
  final String uid = 'yqEenvOBLDPwiX1bwRY8KpfMMmQ2';
  const TimerCircle({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 10,
      initialDuration: 0,
      controller: CountDownController(),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: false,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          cubit.updateEnvarimentIa(uid);
          return "Start";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
