import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_application_1/cubits/calendar/calendar_cubit.dart';
=======
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/pages/PageRegister.dart';
import 'package:flutter_application_1/pages/home.dart';
>>>>>>> e32ea5987db67e4ec905cd3af8cc25023b6cb1a5
import 'package:flutter_application_1/pages/PageLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

<<<<<<< HEAD
Future<void> main() async {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
=======
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
>>>>>>> e32ea5987db67e4ec905cd3af8cc25023b6cb1a5
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Up',
      home: BlocProvider(
        create: (context) => CalendarCubit(),
        child: const AutheticationPage(),
      ),
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
    );
  }
}
