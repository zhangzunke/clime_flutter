import 'package:clime_flutter/screens/loading_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clime',
      theme: ThemeData.dark(),
      home: Loadingscreen(),
    );
  }
}
