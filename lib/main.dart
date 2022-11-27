import 'package:flutter/material.dart';
import 'services/location.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

Location location = Location();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather24x7',
      theme: ThemeData.dark(),
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
