import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String selectedTheme = 'Light';

  String selectedLang = 'English';
  Locale currentLocale = const Locale('en'); // اللغة الافتراضية هي الإنجليزية

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    selectedTheme = prefs.getString('theme') ?? 'Light'; // الافتراضي هو "Light"
    currentTheme = selectedTheme == 'Light' ? ThemeMode.light : ThemeMode.dark;
    selectedLang =
        prefs.getString('language') ?? 'English'; // الافتراضي هو "English"
    currentLocale =
        selectedLang == 'English' ? const Locale('en') : const Locale('ar');

    notifyListeners();
  }

  void changeAppTheme(ThemeMode newTheme, String themeName) {
    if (newTheme == currentTheme) return;

    currentTheme = newTheme;
    selectedTheme = themeName;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('theme', themeName);
    });

    notifyListeners();
  }

  void changeAppLanguage(String newLang) {
    if (newLang == selectedLang) return;

    selectedLang = newLang;

    currentLocale =
        newLang == 'English' ? const Locale('en') : const Locale('ar');

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('language', newLang);
    });

    notifyListeners();
  }

  Future<void> loadSettings() async {
    await _loadSettings();
  }
}
