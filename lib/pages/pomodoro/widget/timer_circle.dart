import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerCircle extends StatefulWidget {
  final MetasCubit cubit;

  const TimerCircle({super.key, required this.cubit});

  @override
  State<TimerCircle> createState() => _TimerCircleState();
}

class _TimerCircleState extends State<TimerCircle> {
  final String uid = 'yqEenvOBLDPwiX1bwRY8KpfMMmQ2';
  bool visibleButton = true;

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<MetasCubit>();
    late CountDownController controler = CountDownController();
    return Column(
      children: [
        CircularCountDownTimer(
          duration: const Duration(minutes: 25).inSeconds,
          initialDuration: 0,
          controller: controler,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          ringColor: Colors.white,
          ringGradient: null,
          fillColor: Colors.white,
          fillGradient: null,
          backgroundColor: Colors.white,
          backgroundGradient: null,
          strokeWidth: 0.0,
          strokeCap: StrokeCap.round,
          textStyle: GoogleFonts.lexendDeca(color: Colors.black, fontSize: 120),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: false,
          onStart: () {
            debugPrint('Countdown Started');
            _cubit.updateEnvarimentIa(uid, 0.2);
            //inserir reforço positivo para ia aqui
          },
          onComplete: () {
            debugPrint('Countdown Ended');
            _cubit.updateEnvarimentIa(uid, 0.8);
            // inserir reforço positivo para ia aqui
          },
          onChange: (String timeStamp) {
            print(timeStamp);
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            // if (!controler.isStarted) {
            //   return "Start";
            // }
            int minutes = duration.inSeconds ~/ 60;
            int seconds = duration.inSeconds % 60;
            return '$minutes:${seconds.toString().padLeft(2, '0')}';
          },
        ),
        Transform.translate(
          offset: const Offset(0, -100),
          child: Text(
            "Hora de estudar ",
            style: GoogleFonts.lexendDeca(
              color: Colors.black,
              fontSize: 36,
            ),
          ),
        ),
        visibleButton
            ? Center(
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF133262),
                ),
                onPressed: () {
                  setState(() {
                    controler.start();
                    visibleButton = false;
                  });
                  // ApiService().sendNotification('yqEenvOBLDPwiX1bwRY8KpfMMmQ2');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Começar',
                    style: GoogleFonts.lexendDeca(color: Colors.white),
                  ),
                ),
              ))
            : Center(
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF133262),
                ),
                onPressed: () {
                  setState(() {
                    controler.pause();
                    visibleButton = true;
                  });
                  // ApiService().sendNotification('yqEenvOBLDPwiX1bwRY8KpfMMmQ2');
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Pausar',
                    style: GoogleFonts.lexendDeca(color: Colors.white),
                  ),
                ),
              )),
      ],
    );
  }
}
