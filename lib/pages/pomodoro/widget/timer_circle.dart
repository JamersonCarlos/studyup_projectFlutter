import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCircle extends StatelessWidget {
  final MetasCubit cubit;
  final String uid = 'yqEenvOBLDPwiX1bwRY8KpfMMmQ2';
  const TimerCircle({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<MetasCubit>();
    late CountDownController controler = CountDownController();
    return Column(
      children: [
        CircularCountDownTimer(
          duration: const Duration(minutes: 30).inSeconds,
          initialDuration: 0,
          controller: controler,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          ringColor: Colors.grey[300]!,
          ringGradient: null,
          fillColor: Color.fromARGB(255, 200, 128, 252),
          fillGradient: null,
          backgroundColor: Color.fromARGB(255, 64, 39, 176),
          backgroundGradient: null,
          strokeWidth: 20.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
              fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: false,
          onStart: () {
            debugPrint('Countdown Started');
            _cubit.updateEnvarimentIa(uid,0.2);
            //inserir reforço positivo para ia aqui
          },
          onComplete: () {
            debugPrint('Countdown Ended');
            _cubit.updateEnvarimentIa(uid,0.8);
            // inserir reforço positivo para ia aqui
          },
          onChange: (String timeStamp) {
            print(timeStamp);
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (!controler.isStarted) {
              return "Start";
            }
            int minutes = duration.inSeconds ~/ 60;
            int seconds = duration.inSeconds % 60;
            return '$minutes:${seconds.toString().padLeft(2, '0')}';
          },
        ),
        Center(
            child: ElevatedButton(
          onPressed: () {
            controler.start();
            // ApiService().sendNotification('yqEenvOBLDPwiX1bwRY8KpfMMmQ2');
          },
          child: const Text('Start Timer'),
        )),
      ],
    );
  }
}
