import 'package:flutter/material.dart';
import 'package:gtk_window/gtk_window.dart';

import 'main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: GTKHeaderBar(),
        body: MainScreen(),
      ),
    );
  }
}
