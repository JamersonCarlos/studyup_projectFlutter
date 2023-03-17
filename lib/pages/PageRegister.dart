import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageLogin.dart';
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

  bool validator_email = false;
  bool validator_pass = false;
  bool exist_email = false;

  @override
  Widget build(BuildContext context) {
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
                      signUp(context);
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
                          signUp(context);
                        },
                        child: const Icon(
                          Icons.arrow_circle_left,
                          color: Color(0xFFBD33D3),
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

  void signUp(BuildContext context) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: pass.text);
      final new_user = <String, String>{
        "username": username.text,
        "email": email.text,
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
