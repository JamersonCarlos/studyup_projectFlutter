import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';
import 'package:flutter_application_1/pages/pomodoro/widget/timer_circle.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MetasCubit cubit = context.read<MetasCubit>();
    return Column(
      children: [
        TimerCircle(cubit: cubit),
        Center(
            child: ElevatedButton(
          onPressed: () {
            // ApiService().sendNotification('yqEenvOBLDPwiX1bwRY8KpfMMmQ2');
          },
          child: const Text('Start Timer'),
        )),
      ],
    );
  }
}
