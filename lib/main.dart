import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';
import 'package:flutter_application_1/cubits/nofications/notifications_cubit.dart';
import 'package:flutter_application_1/services/firebase_options.dart';
import 'package:flutter_application_1/pages/PageLogin.dart';
import 'package:flutter_application_1/services/notifications_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'cubits/calendar/calendar_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Up',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CalendarCubit()),
          BlocProvider(create: (context) => NotificationsCubit(context)),
        ],
        child: const AutheticationPage(),
      ),
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
    );
  }
}
