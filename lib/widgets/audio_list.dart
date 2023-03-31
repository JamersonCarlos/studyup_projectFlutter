import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class recorderAudio extends StatefulWidget {
  recorderAudio({super.key, required this.addAudio});

  Function addAudio;

  @override
  State<recorderAudio> createState() => _recorderAudioState();
}

class _recorderAudioState extends State<recorderAudio> {
  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: "audio");
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');
    widget.addAudio(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF03045E),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 100),
            child: Text(
              "Grave Audio",
              style: TextStyle(color: Colors.white),
            ),
          ),
          StreamBuilder<RecordingDisposition>(
            builder: (context, snapshot) {
              final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              String twoDigits(int n) => n.toString().padLeft(2, '0');

              final twoDigitMinutes =
                  twoDigits(duration.inMinutes.remainder(60));
              final twoDigitSeconds =
                  twoDigits(duration.inSeconds.remainder(60));

              return Text(
                '$twoDigitMinutes:$twoDigitSeconds',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
            stream: recorder.onProgress,
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, shape: CircleBorder()),
            onPressed: () async {
              if (recorder.isRecording) {
                await stopRecorder();
                setState(() {});
              } else {
                await startRecord();
                setState(() {});
              }
            },
            child: Icon(
              recorder.isRecording ? Icons.stop : Icons.mic,
              size: 30,
              color: recorder.isRecording ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
