import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class FormTime extends StatefulWidget {
  const FormTime({super.key});

  @override
  State<FormTime> createState() => _FormTimeState();
}

class _FormTimeState extends State<FormTime> {
  Time _time = Time(hour: 11, minute: 30, second: 20);
  final List<String> days_week = [
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado"
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
    ]
  ];

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
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
                return Container(
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
                                            DateFormat("H:m").format(dateTime);
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
                                            DateFormat("H:m").format(dateTime);
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
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Enviar",
                style: GoogleFonts.roboto(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
