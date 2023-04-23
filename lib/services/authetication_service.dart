import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageMain.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_1/pages/home.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../cubits/metas/metas_cubit.dart';
import '../cubits/nofications/notifications_cubit.dart';
import '../pages/PageFreeTime.dart';
import '../pages/PageLogin.dart';
import 'api_service.dart';

class ServiceAuthentication {
  // late BuildContext context;
  // late String email;
  // late String password;

  ServiceAuthentication();
  FirebaseFirestore db = FirebaseFirestore.instance;
  ApiService serviceNotification = ApiService();

  Future<List<dynamic>> first_login(String user) async {
    DocumentSnapshot doc = await db.collection("users").doc(user).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["metas"];
  }

  void doLogin(BuildContext context, CalendarCubit _cubit, String email,
      String password) async {
    var data;
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (user != null) {
        List data = await first_login(user.user!.uid);
        if (data.isEmpty) {
          serviceNotification.getFirstLogin(user.user!.uid);
        }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => menuMain(
                      uid: user.user!.uid,
                      // pagelocal: 1,
                    )),
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
        "metas": [],
        "anotations": [],
      };

      //Add new user in collection users
      db.collection('users').doc(user.user!.uid).set(newUser);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CalendarCubit()),
            BlocProvider(create: (context) => NotificationsCubit(context)),
            BlocProvider(create: (context) => MetasCubit()),
          ],
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
