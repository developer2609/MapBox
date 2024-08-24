import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.green,
        brightness: Brightness.light,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        headline6: TextStyle(color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.green,
        brightness: Brightness.dark,
      ),
      bottomAppBarColor: Colors.black,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
