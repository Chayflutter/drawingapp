import 'package:flutter/material.dart';
import 'package:myapp/pages/drawingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawing app',
      home: Scaffold(

        body: Center(
          child:  DrawingPage() ,
        ),
      ),
    );
  }
}

