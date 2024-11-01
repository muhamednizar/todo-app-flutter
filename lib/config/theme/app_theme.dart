import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/colors_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      primaryColor: ColorsManager.blueColor,
      dividerColor: ColorsManager.blueColor,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.blueColor,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyles.appBarTextStyle,
      ),
      scaffoldBackgroundColor: ColorsManager.scaffoldBgColor,
      bottomAppBarTheme: BottomAppBarTheme(
          color: ColorsManager.whiteColor,
          shape: CircularNotchedRectangle(),
          elevation: 14),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          iconSize: 35,
          elevation: 0,
          backgroundColor: ColorsManager.blueColor,
          shape: StadiumBorder(
              side: BorderSide(color: ColorsManager.whiteColor, width: 4))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 32),
          selectedItemColor: ColorsManager.blueColor,
          unselectedItemColor: ColorsManager.greyColor),
      cardTheme: CardTheme(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.transparent,
        elevation: 0,
      ),
      textTheme: TextTheme(
          titleMedium: TextStyles.cardTitleTextStyle,
          labelSmall: TextStyles.settingsLabelTextStyle));
}
