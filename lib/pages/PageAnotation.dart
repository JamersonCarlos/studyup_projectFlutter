import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/play_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Anotation extends StatefulWidget {
  Anotation({super.key, required this.infoAnotation});

  Map<String, dynamic> infoAnotation;

  @override
  State<Anotation> createState() => _AnotationState();
}

class _AnotationState extends State<Anotation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.infoAnotation["title"],
                style: GoogleFonts.lexendDeca(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            Center(
              child: Container(
                color: Colors.black,
                height: 2,
                width: 334,
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            Text(
              widget.infoAnotation["description"],
              style: GoogleFonts.lexendDeca(color: Colors.black),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.infoAnotation["links"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url =
                            Uri.parse(widget.infoAnotation["links"][index]);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Text(
                        widget.infoAnotation["links"][index],
                        style: GoogleFonts.lexendDeca(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.infoAnotation["audios"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: playAudio(
                        filepath:
                            widget.infoAnotation["audios"][index].toString()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.infoAnotation["imagens"].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        height: 150,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(
                              File(widget.infoAnotation["imagens"][index]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
