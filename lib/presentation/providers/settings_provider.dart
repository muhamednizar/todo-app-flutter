import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  // إعدادات الثيم
  ThemeMode currentTheme = ThemeMode.light;
  String selectedTheme = 'Light';

  // إعدادات اللغة
  String selectedLang = 'English';
  Locale currentLocale = const Locale('en'); // اللغة الافتراضية هي الإنجليزية

  // تحميل الإعدادات من SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // تحميل الثيم من SharedPreferences
    selectedTheme = prefs.getString('theme') ?? 'Light'; // الافتراضي هو "Light"
    currentTheme = selectedTheme == 'Light' ? ThemeMode.light : ThemeMode.dark;

    // تحميل اللغة من SharedPreferences
    selectedLang =
        prefs.getString('language') ?? 'English'; // الافتراضي هو "English"
    currentLocale =
        selectedLang == 'English' ? const Locale('en') : const Locale('ar');

    notifyListeners(); // إشعار المستمعين بتغيير الإعدادات
  }

  // تغيير الثيم
  void changeAppTheme(ThemeMode newTheme, String themeName) {
    if (newTheme == currentTheme) return;

    currentTheme = newTheme;
    selectedTheme = themeName;

    // حفظ الثيم المختار في SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('theme', themeName);
    });

    notifyListeners();
  }

  // تغيير اللغة
  void changeAppLanguage(String newLang) {
    if (newLang == selectedLang) return;

    selectedLang = newLang;

    // تحديث اللغة بناءً على الاختيار
    currentLocale =
        newLang == 'English' ? const Locale('en') : const Locale('ar');

    // حفظ اللغة المختارة في SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('language', newLang);
    });

    notifyListeners();
  }

  // استدعاء الدالة _loadSettings عند بداية التطبيق
  Future<void> loadSettings() async {
    await _loadSettings();
  }
}
