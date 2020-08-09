import 'package:flutter/material.dart';

class ThemeHelper { 

  static final ThemeHelper _aparenciaHelper = ThemeHelper._internal();
  static ThemeHelper get instance { return _aparenciaHelper; }
  ThemeHelper._internal();
  
  ThemeData get classic {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      indicatorColor: Colors.black26,
      cursorColor: Colors.blueGrey.shade700,
      scaffoldBackgroundColor: Colors.white,
      disabledColor: Colors.black45,
      cardColor: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(
        caption: TextStyle(
          color: Colors.blueGrey.shade800,
        ),
        headline6: TextStyle(
          color: Colors.blueGrey.shade700,
        ),
        bodyText1: TextStyle(
          color: Colors.grey.shade700,
        ),
        overline: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey.shade600,
        height: 40,
      ),
      buttonColor: Colors.blueGrey.shade600,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black87,),
        color: Colors.white,
        brightness: Brightness.light,
        elevation: 5,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.blueGrey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  ThemeData get dark {
    return ThemeData(
      primaryColor: Colors.white,
      backgroundColor: Colors.white,
      indicatorColor: Colors.black26,
      cursorColor: Colors.blueGrey.shade700,
      scaffoldBackgroundColor: Colors.white,
      disabledColor: Colors.black45,
      cardColor: Colors.white,
      brightness: Brightness.light,
      textTheme: TextTheme(
        caption: TextStyle(
          color: Colors.blueGrey.shade800,
        ),
        headline6: TextStyle(
          color: Colors.blueGrey.shade700,
        ),
        bodyText1: TextStyle(
          color: Colors.grey.shade700,
        ),
        overline: TextStyle(
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey.shade600,
        height: 40,
      ),
      buttonColor: Colors.blueGrey.shade600,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black87,),
        color: Colors.white,
        brightness: Brightness.light,
        elevation: 5,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.blueGrey.shade800,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}