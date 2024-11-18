import 'dart:math';

import 'package:flutter/material.dart';

import './pages/login_page.dart';

void main() => runApp(MyApp());

final ValueNotifier<Color> themeColor = ValueNotifier<Color>(
  const Color.fromRGBO(125, 191, 211, 1.0),
);

// Calculate a lighter color based on the current theme.
Color calculateLightColor(Color color) {
  return Color.fromARGB(
    color.alpha,
    min(color.red + 60, 255),
    min(color.green + 60, 255),
    min(color.blue + 60, 255),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedLoginPage(),
    );
  }
}
