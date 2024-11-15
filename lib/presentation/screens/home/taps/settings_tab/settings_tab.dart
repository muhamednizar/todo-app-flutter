import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/presentation/providers/settings_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme Section
          Text(
            AppLocalizations.of(context)!.settingsTheme,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2)),
            child: Row(
              children: [
                Text(
                  // عرض الثيم الحالي بناءً على اللغة
                  settingsProvider.selectedTheme == 'Light'
                      ? AppLocalizations.of(context)!.light
                      : AppLocalizations.of(context)!.dark,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
                const Spacer(),
                DropdownButton<String>(
                  underline: SizedBox.shrink(),
                  dropdownColor:
                      settingsProvider.currentTheme == ThemeMode.light
                          ? Colors.white
                          : ColorsManager.blackAccent,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: settingsProvider.currentTheme == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                  value: settingsProvider.selectedTheme,
                  items: [
                    DropdownMenuItem(
                      value: 'Light',
                      child: Text(AppLocalizations.of(context)!.light),
                    ),
                    DropdownMenuItem(
                      value: 'Dark',
                      child: Text(AppLocalizations.of(context)!.dark),
                    ),
                  ],
                  onChanged: (newTheme) {
                    if (newTheme == 'Light') {
                      settingsProvider.changeAppTheme(ThemeMode.light, 'Light');
                    } else if (newTheme == 'Dark') {
                      settingsProvider.changeAppTheme(ThemeMode.dark, 'Dark');
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // Language Section
          Text(
            AppLocalizations.of(context)!.settingsLang,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2)),
            child: Row(
              children: [
                Text(
                  // عرض اللغة الحالية بناءً على اللغة
                  settingsProvider.selectedLang == 'English'
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
                const Spacer(),
                DropdownButton<String>(
                  underline: SizedBox.shrink(),
                  dropdownColor:
                      settingsProvider.currentTheme == ThemeMode.light
                          ? Colors.white
                          : ColorsManager.blackAccent,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: settingsProvider.currentTheme == ThemeMode.light
                          ? Colors.black
                          : Colors.white),
                  value: settingsProvider.selectedLang,
                  items: [
                    DropdownMenuItem(
                      value: 'English',
                      child: Text(AppLocalizations.of(context)!.english),
                    ),
                    DropdownMenuItem(
                      value: 'Arabic',
                      child: Text(AppLocalizations.of(context)!.arabic),
                    ),
                  ],
                  onChanged: (value) {
                    settingsProvider.changeAppLanguage(value!);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          Center(
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
              ),
              onPressed: () {
                signOut();
              },
              child: Text(AppLocalizations.of(context)!.logOut),
            ),
          ),
        ],
      ),
    );
  }

  // تسجيل الخروج
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
  }
}
