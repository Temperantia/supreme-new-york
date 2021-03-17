import 'package:flutter/material.dart';
import 'package:supreme/colors.dart';

ThemeData theme = ThemeData(
    accentColor: Colors.white,
    splashColor: Colors.white,
    hintColor: Colors.white,
    primaryColor: primary,
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.white),
      overline: TextStyle(color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: whiteTransparent)),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: grey)),
        fillColor: greySecondary,
        filled: true,
        hintStyle: TextStyle(color: grey)),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(primary),
      trackColor: MaterialStateProperty.all(grey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            backgroundColor: MaterialStateProperty.all(primary))));
