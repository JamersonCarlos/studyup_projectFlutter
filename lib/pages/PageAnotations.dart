import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/anotations.dart';
import '../widgets/audio_list.dart';
import '../widgets/play_audio.dart';

class Anotations extends StatefulWidget {
  Anotations(
      {super.key,
      required this.title,
      required this.uid,
      required this.index_disciplina});

  String title;
  String uid;
  int index_disciplina;

  @override
  State<Anotations> createState() => _AnotationsState();
}

class _AnotationsState extends State<Anotations> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  int indexBottomNavigation = 1;
  ImagePicker imagePicker = ImagePicker();
  bool floatingButtonActivate = true;
  String textInput = "";
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController linkInput = TextEditingController();
  List<String> selectImages = [];
  List<String> links = [];
  List<String> audios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: const Color(0xFF03045E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        leading: const Icon(
          Icons.bookmark_added_outlined,
          color: Colors.white,
          size: 30,
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: TextField(
                  controller: titleInput,
                  textAlign: TextAlign.start,
                  cursorColor: Colors.blueAccent,
                  decoration: const InputDecoration(
                    hintText: "Fórmula de Bhaskara",
                    hintStyle: TextStyle(fontSize: 14),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    labelText: "Titulo da anotação",
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  controller: descriptionInput,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 14),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Links",
                style: GoogleFonts.roboto(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: links.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF03045E),
                          borderRadius: BorderRadius.circular(5)),
                      child: GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(links[index]);
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    links[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    links.removeAt(index);
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        cursorColor: Colors.black,
                        onTap: () {
                          setState(() {
                            floatingButtonActivate = false;
                          });
                        },
                        controller: linkInput,
                        decoration: const InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          floatingButtonActivate = true;
                          currentFocus.unfocus();
                        }
                        bool _validURL = Uri.parse(linkInput.text).isAbsolute;
                        if (linkInput.text.isNotEmpty) {
                          if (_validURL) {
                            links.add(linkInput.text);
                            linkInput.clear();
                          } else {
                            linkInput.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Link Invalido !",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red.shade400,
                              ),
                            );
                          }
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      backgroundColor: Color(0xFF03045E),
                    ),
                    child: const Icon(
                      Icons.add_link,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              selectImages.isNotEmpty
                  ? Text(
                      "Imagens",
                      style: GoogleFonts.roboto(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: selectImages.isEmpty ? 0 : 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: selectImages.length,
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
                                  image: FileImage(File(selectImages[index])))),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(
                "Audios",
                style: GoogleFonts.roboto(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: audios.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: playAudio(
                      filepath: audios[index],
                    ),
                  );
                },
              ),
              recorderAudio(addAudio: addAudio),
              const SizedBox(
                height: 30,
              ),
              (selectImages.isNotEmpty ||
                          links.isNotEmpty ||
                          descriptionInput.text.isNotEmpty) &&
                      titleInput.text.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              newAnotation(
                                  titleInput.text,
                                  descriptionInput.text,
                                  selectImages,
                                  links,
                                  audios);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Enviar Anotação",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButtonActivate
          ? SpeedDial(
              icon: Icons.add,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF03045E),
              activeIcon: Icons.close,
              elevation: 1,
              spacing: 8,
              children: [
                SpeedDialChild(
                    elevation: 0,
                    backgroundColor: Colors.amberAccent,
                    shape: StadiumBorder(),
                    child: Icon(Icons.camera_alt_outlined),
                    onTap: () async {
                      final XFile? imageTemp = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      if (imageTemp != null) {
                        setState(() {
                          selectImages.add(imageTemp.path);
                        });
                      }
                    }),
                SpeedDialChild(
                    elevation: 0,
                    backgroundColor: Colors.amberAccent,
                    shape: StadiumBorder(),
                    child: Icon(Icons.photo_camera_back_rounded),
                    onTap: () async {
                      final XFile? imageTemp = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (imageTemp != null) {
                        setState(() {
                          selectImages.add(imageTemp.path);
                        });
                      }
                    }),
              ],
            )
          : null,
    );
  }

  void addAudio(String audioPath) {
    setState(() {
      audios.add(audioPath);
    });
  }

  void newAnotation(String title, String description, List<String> selectImages,
      List<String> links, List<String> audios) {
    Map<String, dynamic> newAnotation = Anotation(
        envio: DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now()),
        title: titleInput.text,
        description: descriptionInput.text,
        links: links,
        audios: audios,
        imagens: selectImages,
        videos: []).toMap();
    newAnotation["disciplina"] = widget.title;

    db.collection("users").doc(widget.uid).update(
      {
        "anotations": FieldValue.arrayUnion(
          [newAnotation],
        )
      },
    );
  }
}
