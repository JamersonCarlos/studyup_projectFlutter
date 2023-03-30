import 'dart:html';

import 'package:flutter_sound_lite/flutter_sound.dart';

final pathToSaveAudio = 'audio_example.acc';

class SoundedRecorder {
  FlutterSoundRecorder? _audioRecorder;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder!.openAudioSession();
  }

  Future _record() async {
    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
