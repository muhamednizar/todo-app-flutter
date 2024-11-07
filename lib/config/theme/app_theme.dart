import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/colors_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      indicatorColor: ColorsManager.whiteColor,
      primaryColor: ColorsManager.blueColor,
      dividerColor: ColorsManager.blueColor,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.blueColor,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyles.appBarTextStyle,
      ),
      scaffoldBackgroundColor: ColorsManager.lightscaffoldBgColor,
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
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15)))),
      textTheme: TextTheme(
          bodySmall:
              TextStyles.darkcardDateTextStyle.copyWith(color: Colors.black),
          titleMedium: TextStyles.cardTitleTextStyle,
          labelSmall: TextStyles.settingsLabelTextStyle));
  static ThemeData darkTheme = ThemeData(
      useMaterial3: false,
      indicatorColor: ColorsManager.blackAccent,
      primaryColor: ColorsManager.blueColor,
      dividerColor: ColorsManager.blueColor,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.blueColor,
        elevation: 4,
        centerTitle: true,
        titleTextStyle: TextStyles.darkappBarTextStyle,
      ),
      scaffoldBackgroundColor: ColorsManager.black,
      bottomAppBarTheme: BottomAppBarTheme(
          color: ColorsManager.blackAccent,
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
        color: ColorsManager.blackAccent,
        elevation: 20,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: ColorsManager.blackAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15)))),
      textTheme: TextTheme(
          bodySmall: TextStyles.darkcardDateTextStyle,
          titleMedium: TextStyles.cardTitleTextStyle,
          labelSmall: TextStyles.settingsLabelTextStyle
              .copyWith(color: ColorsManager.whiteColor)));
}
