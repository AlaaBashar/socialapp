import 'package:flutter/material.dart';

class MyThemeApp{
  static final ThemeData? lightMode = ThemeData(
    ///---------------------------lightMode--------------------------------------
    primarySwatch: Colors.blue,
    ///-----------------------------------------------------------------
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3
      ),
    ),
    ///-----------------------------------------------------------------
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700),
    ),
    ///-----------------------------------------------------------------
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
      ),
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: Colors.black),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.black,
    ),
    ///-----------------------------------------------------------------

  );

  ///-------------------------darkMode----------------------------------------

  static final ThemeData? darkMode =  ThemeData(
    ///-----------------------------------------------------------------
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.3
      ),
    ),
    ///-----------------------------------------------------------------
    scaffoldBackgroundColor: Colors.grey.shade900,
    ///-----------------------------------------------------------------
    colorScheme: const ColorScheme.dark(),
    ///-----------------------------------------------------------------
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700),
    ),
    ///-----------------------------------------------------------------
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color: Colors.white),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
    ),
    ///-----------------------------------------------------------------

  );
}
/// " gradlew signingReport " to generate SH1