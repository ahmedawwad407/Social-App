import 'package:f_project/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold)),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.blue
      ),
      focusedBorder: OutlineInputBorder(
        
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
      ),

       enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20,
        backgroundColor: Colors.white),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: defaultColor),
    textTheme: TextTheme(
      headline6: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      headline3: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
      caption: TextStyle(color: Colors.black),
      subtitle1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.3),
      subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.3),
    ),
    fontFamily: 'Roboto');

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('102030'),
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('102030'),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor('102030'),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold)),
    cardColor: HexColor('102030'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        elevation: 20,
        backgroundColor: HexColor('102030')),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: defaultColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white
      ),
      focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  
      ),
      prefixIconColor: Colors.white,

       enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      headline3: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      subtitle1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.3),
      subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.3),
      caption: TextStyle(color: Colors.white, height: 1.3),
    ),
    fontFamily: 'Roboto');
