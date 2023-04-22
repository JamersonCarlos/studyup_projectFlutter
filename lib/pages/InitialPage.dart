import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../cubits/metas/metas_cubit.dart';
import '../cubits/nofications/notifications_cubit.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CalendarCubit()),
              BlocProvider(create: (context) => NotificationsCubit(context)),
              BlocProvider(create: (context) => MetasCubit()),
            ],
            child: const AutheticationPage(),
          );
        },
      ), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Transform.translate(
        offset: Offset(0, 20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SvgPicture.asset('assets/img/initial1.svg'),
            SvgPicture.asset('assets/img/initial2.svg'),
            Transform.translate(
              offset: Offset(0, 100),
              child: Column(
                children: [
                  Image.asset('assets/img/iconMain.jpg', width: 300),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "STUDYUP",
                    style: GoogleFonts.balooPaaji2(
                      color: Colors.white,
                      fontSize: 45,
                      letterSpacing: 5,
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
