import 'package:backg/screens/constant.dart';
import 'package:backg/screens/homepage.dart';
import 'package:backg/screens/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jeph Cakes',
      routes: {
        '/signup': (BuildContext context) => SignUpPage(),
        '/login': (BuildContext context) => HomePage()
      },
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: HomePage(),
    );
  }
}
