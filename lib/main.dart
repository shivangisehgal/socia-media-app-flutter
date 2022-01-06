import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {

  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
