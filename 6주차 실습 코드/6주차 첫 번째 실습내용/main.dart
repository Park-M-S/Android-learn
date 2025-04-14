import 'package:b_6_first/second_page.dart';
import 'package:flutter/material.dart';
import 'package:b_6_first/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
      routes: {
          '/first':(context) => FirstPage(),
          '/second':(context) => SecondPage(),
      },
    );
  }
}

