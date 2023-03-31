import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class playAudio extends StatefulWidget {
  playAudio({super.key, required this.filepath});

  String filepath;

  @override
  State<playAudio> createState() => _playAudioState();
}

class _playAudioState extends State<playAudio> {
  AudioPlayer? audioPlayer;

  _runAudio(String path) async {
    try {
      await audioPlayer!.play(AssetSource(path));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: Color(0xFF03045E), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Play Audio",
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.play_circle_fill_sharp,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    ));
  }
}
