import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors_manager.dart';

class TextStyles {
  static TextStyle appBarTextStyle = GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: ColorsManager.whiteColor);
  static TextStyle cardTitleTextStyle = GoogleFonts.poppins(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blueColor);
  static TextStyle settingsLabelTextStyle = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF303030));
  static TextStyle hintTextStyle = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w300, color: Color(0xFF000000));
  static TextStyle registerLabelTextStyle = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
  static TextStyle registerBtnTextStyle = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF004182));
}
