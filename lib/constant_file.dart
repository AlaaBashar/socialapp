import 'package:flutter/material.dart';
class MyThemeApp{
  ///--------------------------lightMode---------------------------------------
  static final ThemeData? lightMode = ThemeData(
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
      button:TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3
      ),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.3
      ),
      headline3:  TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.3
      ),

    ),
    ///-----------------------------------------------------------------

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
  ///--------------------------darkMode----------------------------------------
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
      button:TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.3
      ),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.3
      ),
      headline3:  TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
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



/// " gradlew signingReport " ==> TO GENERATE SH1 FOR FIREBASE


///       LayoutBuilder(
///          builder: (_, constraints){
///            return SingleChildScrollView(
///              physics: const BouncingScrollPhysics(),
///          child: ConstrainedBox(
///            constraints: BoxConstraints(
///                minWidth: constraints.maxWidth,
///                minHeight: constraints.maxHeight
///            ),
///            child: IntrinsicHeight(
///              child: ,
///            ),
///          ),
///        );
///          }
///      )



///    CustomScrollView(
///        physics: const BouncingScrollPhysics(),
///        slivers: [
///          SliverFillRemaining(
///            hasScrollBody: false,
///            child:,
///          ),
///        ],
///      ),


