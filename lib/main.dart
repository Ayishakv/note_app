import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/utils/app_sessions.dart';

import 'package:note_app/view/splash_screen/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(AppSessions.NOTEBOX);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
