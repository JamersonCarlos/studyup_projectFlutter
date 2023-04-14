import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import 'home.dart';

class FormTime extends StatefulWidget {
  const FormTime({super.key, required this.uid});

  final String uid;

  @override
  State<FormTime> createState() => _FormTimeState();
}

class _FormTimeState extends State<FormTime> {
  Time _time = Time(hour: 11, minute: 30, second: 20);
  FirebaseFirestore db = FirebaseFirestore.instance;

  final List<String> days_week = [
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado",
    "Domingo"
  ];

  List<List<Map<String, dynamic>>> free_times = [
    [
      {"start": "00:00", "end": "00:00"}
    ],
    [
      {"start": "00:00", "end": "00:00"}
    ],
    [
      {"start": "00:00", "end": "00:00"}
    ],
    [
      {"start": "00:00", "end": "00:00"}
    ],
    [
      {"start": "00:00", "end": "00:00"}
    ],
    [
      {"start": "00:00", "end": "00:00"}
    ],
    [
      {"start": "00:00", "end": "00:00"}
    ],
  ];

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  bool TimeValid(String start, String end) {
    var listTimeStart = start.split(":");
    var listTimeEnd = end.split(":");
    bool validTime =
        (int.parse(listTimeEnd[0]) - int.parse(listTimeStart[0])) > 0
            ? true
            : false;
    print(validTime);
    return validTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(164, 3, 5, 94),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Image.asset('assets/img/free_time.png'),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: days_week.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TimeValid(free_times[index][0]["start"],
                              free_times[index][0]["end"])
                          ? Colors.blueAccent
                          : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            days_week[index],
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Das  ",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.timer_outlined,
                                          color: Colors.black,
                                        ),
                                        Text(free_times[index][0]["start"])
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      context: context,
                                      value: _time,
                                      onChange: onTimeChanged,
                                      onChangeDateTime: (DateTime dateTime) {
                                        setState(() {
                                          free_times[index][0]["start"] =
                                              DateFormat("H:m")
                                                  .format(dateTime);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                              Text(
                                "   as   ",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.timer_outlined,
                                          color: Colors.black,
                                        ),
                                        Text(free_times[index][0]["end"])
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      context: context,
                                      value: _time,
                                      onChange: onTimeChanged,
                                      onChangeDateTime: (DateTime dateTime) {
                                        setState(() {
                                          free_times[index][0]["end"] =
                                              DateFormat("H:m")
                                                  .format(dateTime);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: () {
                List<dynamic> listInvalid = [];
                List<dynamic> listvalid = [];
                for (int i = 0; i < free_times.length; i++) {
                  if (TimeValid(
                      free_times[i][0]["start"], free_times[i][0]["end"])) {
                    listvalid.add(free_times[i][0]);
                  } else {
                    listInvalid.add(free_times[i][0]);
                  }
                }
                if (listInvalid.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 3),
                      content: Text(
                        "Horários em vermelho estão inválidos!",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  db.collection("users").doc(widget.uid).set(
                      {"horários_livres": listvalid},
                      SetOptions(merge: true)).then(
                    (value) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomeApp(user: widget.uid,pagelocal: 1,)),
                          (Route<dynamic> route) => false);
                    },
                  );
                }
              },
              child: Text(
                "    Enviar    ",
                style: GoogleFonts.roboto(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          elevation: 10,
          title: Text(
            'Horários Inválidos',
            style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Os horários em vermelho estão inválidos, corriga e tente enviar novamente!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
