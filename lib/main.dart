import 'package:flutter/material.dart';
import 'package:gpt_voice_assistant_app/home_page.dart';
import 'package:gpt_voice_assistant_app/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice GPT',
      theme: ThemeData(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.backgroundColor,
        ),
      ),
      home: const HomePage(),
    );
  }
}


// where to add font in main.dart?: 