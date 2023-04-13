import 'package:flutter/material.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: const Center(
        child: Text('Pomodoro start'),
      ),
    );
  }
}
