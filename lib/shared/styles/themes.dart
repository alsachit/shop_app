import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleTextStyle: const TextStyle(
        color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold
    ),
      backgroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),
      iconTheme: IconThemeData(
          color: HexColor('333739')
      ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 5,
    backgroundColor: Colors.white,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold
    )
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black
    )
  ),
  fontFamily: 'Gotham',
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("333739"),
  primarySwatch: Colors.teal,
  appBarTheme:  AppBarTheme(
      backgroundColor: HexColor("333739"),
      titleTextStyle: const TextStyle(color: Colors.white),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor("333739"),
          statusBarIconBrightness: Brightness.light
      )
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 5,
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white
        )
    ),
    fontFamily: 'Gotham'
);