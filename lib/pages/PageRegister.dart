import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/calendar/calendar_cubit.dart';
import 'package:flutter_application_1/pages/PageLogin.dart';
import 'package:flutter_application_1/services/authetication.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final CalendarCubit _cubit = CalendarCubit();

  bool validator_email = false;
  bool validator_pass = false;
  bool exist_email = false;

  @override
  Widget build(BuildContext context) {
    ServiceAuthentication service = ServiceAuthentication();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/img/top_background1.svg'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Create account",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5.0,
              shadowColor: Color.fromARGB(134, 158, 158, 158),
              child: TextFormField(
                obscureText: false,
                autofocus: false,
                controller: username,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Username',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFFC8C8C8),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5.0,
              shadowColor: Color.fromARGB(134, 158, 158, 158),
              child: TextFormField(
                obscureText: false,
                autofocus: false,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Email',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: const Color(0xFFC8C8C8),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5.0,
              shadowColor: Color.fromARGB(134, 158, 158, 158),
              child: TextFormField(
                obscureText: false,
                autofocus: false,
                controller: pass,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'password',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFFC8C8C8),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Create",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // FocusScope.of(context).requestFocus(FocusNode());
                      service.signUp(context, _cubit, email.text, pass.text,
                          username.text);
                    },
                    iconSize: 45,
                    icon: SvgPicture.asset('assets/img/button.svg'))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SvgPicture.asset('assets/img/bottom_background.svg'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_circle_left,
                          color: Color(0xFF03045E),
                          size: 50,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
