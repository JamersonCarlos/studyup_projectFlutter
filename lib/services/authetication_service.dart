import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_1/pages/home.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../pages/PageFreeTime.dart';
import '../pages/PageLogin.dart';

class ServiceAuthentication {
  // late BuildContext context;
  // late String email;
  // late String password;

  ServiceAuthentication();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<dynamic>> first_login(String user) async {
    DocumentSnapshot doc = await db.collection("users").doc(user).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["horários_livres"];
  }

  void doLogin(BuildContext context, CalendarCubit _cubit, String email,
      String password) async {
    var data;
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        // List data = await first_login(user.user!.uid);
        // if (data.isNotEmpty) {
        //   Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(
        //           builder: (context) => HomeApp(user: user.user!.uid)),
        //       (Route<dynamic> route) => false);
        // } else {
        //   Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(
        //           builder: (context) => FormTime(uid: user.user!.uid)),
        //       (Route<dynamic> route) => false);
        // }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomeApp(user: user.user!.uid)),
            (Route<dynamic> route) => false);
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

  void signUp(BuildContext context, CalendarCubit _cubit, String email,
      String senha, String username) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email.trim(), password: senha);
      final newUser = <String, dynamic>{
        "username": username,
        "email": email,
        "disciplinas": [],
        "horários_livres": [],
        "QTableIA": [],
      };

      //Add new user in collection users
      db.collection('users').doc(user.user!.uid).set(newUser);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return BlocProvider<CalendarCubit>.value(
          value: _cubit,
          child: const AutheticationPage(),
        );
      }), (Route<dynamic> route) => false);
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
