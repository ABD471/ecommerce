import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.indigo,
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: GoogleFonts.cairoTextTheme().copyWith(
    headlineLarge: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
    bodyMedium: GoogleFonts.cairo(fontSize: 16),
    bodySmall: GoogleFonts.cairo(fontSize: 14, color: Colors.grey[700]),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.indigo.shade100,
    labelStyle: GoogleFonts.cairo(fontSize: 14),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: GoogleFonts.cairo(fontSize: 16),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme).copyWith(
    headlineLarge: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
    bodyMedium: GoogleFonts.cairo(fontSize: 16),
    bodySmall: GoogleFonts.cairo(fontSize: 14, color: Colors.grey[300]),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Colors.teal.shade700,
    labelStyle: GoogleFonts.cairo(fontSize: 14),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: GoogleFonts.cairo(fontSize: 16),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
);
