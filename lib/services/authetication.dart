import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/PageRegister.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../pages/PageLogin.dart';
import '../pages/calendar/calendar_page.dart';

import 'package:flutter/widgets.dart';

class ServiceAuthentication {
  // late BuildContext context;
  // late String email;
  // late String password;

  ServiceAuthentication();
  FirebaseFirestore db = FirebaseFirestore.instance;

  void doLogin(BuildContext context, CalendarCubit _cubit, String email,
      String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return BlocProvider<CalendarCubit>.value(
            value: _cubit,
            child: const CalendarPage(),
          );
        }), (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF3813C2),
            content: Text(
              textAlign: TextAlign.center,
              'Usuário não encontrado! Cadastra-se ',
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  void signUp(
      BuildContext context, String email, String senha, String username) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email.trim(), password: senha);
      final new_user = <String, String>{
        "username": username,
        "email": email,
      };

      //Add new user in collection users
      db.collection('users').doc(user.user!.uid).set(new_user);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AutheticationPage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'invalid-email') {
        scaffoldMessenger(context, 'Invalid Email');
      } else if (e.code == 'weak-password') {
        scaffoldMessenger(context, 'Password min length 6');
      } else if (e.code == 'email-already-in-use') {
        scaffoldMessenger(context, 'Email in use');
      }
    }
  }

  void scaffoldMessenger(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(188, 57, 19, 194),
      content: Text(
        value,
        style: GoogleFonts.lato(
          color: Colors.white,
        ),
      ),
    ));
  }
}
