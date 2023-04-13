import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body:  Center(
        child: ElevatedButton(
          onPressed: () {
              ApiService().sendNotification('yqEenvOBLDPwiX1bwRY8KpfMMmQ2');
               
          },
          child: Text('Senvie uma notificação'),
        )
      ),
    );
  }
}
