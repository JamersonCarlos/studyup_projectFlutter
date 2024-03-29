// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageAnotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../PageNewAnotations.dart';

class PomodoroPage extends StatefulWidget {
  PomodoroPage({Key? key, required this.nameSubject}) : super(key: key);

  late String nameSubject;

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  bool visibleButton = true;
  CountDownController controllerTime = CountDownController();
  List<dynamic> listSubjects = [];
  bool validadorSubject = false;

  // final List<String> genderItems = [
  //   'Male',
  //   'Female',
  // ];

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MetasCubit cubit = context.read<MetasCubit>();
    cubit.getMetasByUidUserForPormodoroPage();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          widget.nameSubject == ""
              ? Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: BlocConsumer<MetasCubit, MetasState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is MetasLoadedPomodoro) {
                        return DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorText: validadorSubject
                                ? "   Escolha uma disciplina"
                                : null,
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Selecione uma Disciplina',
                            style: TextStyle(fontSize: 14),
                          ),
                          items: state.metas
                              .map((item) => DropdownMenuItem<String>(
                                    value: item["title"],
                                    child: Text(
                                      item["title"],
                                      style: GoogleFonts.lexendDeca(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            selectedValue = value.toString();
                          },
                          value: selectedValue,
                          buttonStyleData: const ButtonStyleData(
                            height: 60,
                            padding: EdgeInsets.only(left: 20, right: 10),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                )
              : Center(
                  child: Text(
                    widget.nameSubject,
                    style: GoogleFonts.balooPaaji2(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
          CircularCountDownTimer(
            duration: const Duration(seconds: 10).inSeconds,
            initialDuration: 0,
            controller: controllerTime,
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
            textStyle:
                GoogleFonts.lexendDeca(color: Colors.black, fontSize: 120),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () async {
              var data = await cubit.service.getMetasByUidUser(cubit.uid);
              print(data);
              // cubit.updateEnvarimentIa(selectedValue ?? "",cubit.uid, 0.2,0,listSubjects['horario_meta']);
              // inserir reforço positivo para ia aqui
            },
            onComplete: () {
              showCompleteDialog(context, cubit, selectedValue ?? "");
              // cubit.updateEnvarimentIa(selectedValue ?? "",cubit.uid, 0.8,25,listSubjects['horario_meta']);
              // inserir reforço positivo para ia aqui
            },
            onChange: (String timeStamp) {
              print(timeStamp);
            },
            timeFormatterFunction: (defaultFormatterFunction, duration) {
              // if (!controllerTime.isStarted) {
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
                      if (selectedValue != null) {
                        controllerTime.start();
                        widget.nameSubject = selectedValue!;
                        visibleButton = false;
                      } else {
                        setState(() {
                          validadorSubject = true;
                        });
                      }
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
                      controllerTime.pause();
                      visibleButton = true;
                    });
                    // ApiService().sendNotification('yqEenvOBLDPwiX1bwRY8KpfMMmQ2');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text(
                      'Pausar',
                      style: GoogleFonts.lexendDeca(color: Colors.white),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}

Future<void> showCompleteDialog(
    BuildContext context, MetasCubit cubit, String disciplina) async {
  return Dialogs.materialDialog(
    color: Colors.white,
    msg: 'Deseja criar uma nova anotação?',
    title: 'Concluido',
    lottieBuilder: Lottie.asset(
      'assets/complete.json',
      fit: BoxFit.contain,
    ),
    context: context,
    actions: [
      IconsButton(
        onPressed: () {
          Navigator.pop(context);
        },
        text: 'cancelar',
        iconData: Icons.done,
        color: Colors.grey,
        textStyle: const TextStyle(color: Colors.black),
        iconColor: Colors.white,
      ),
      IconsButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return Anotations(
                index_disciplina: 0,
                title: disciplina,
                uid: cubit.uid,
              );
            },
          ));
        },
        text: 'Sim',
        iconData: Icons.done,
        color: Colors.blue,
        textStyle: const TextStyle(color: Colors.white),
        iconColor: Colors.white,
      ),
    ],
  );
}
