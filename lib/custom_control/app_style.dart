import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleGlobal {
  static const color = Color.fromARGB(255, 189, 87, 192);
  static const fontWeight = FontWeight.bold;
  static const TextStyle h3 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle h4 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle redirect = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 131, 185, 230));
  static TextStyle text_button =
      GoogleFonts.tourney(
        fontSize: 30, 
        fontWeight: FontWeight.bold,
        color: Colors.white);
  static TextStyle text_fancy = 
  GoogleFonts.dancingScript(
    fontSize: 15, 
    fontWeight: FontWeight.bold, 
    color: Colors.white);
}
