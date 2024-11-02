import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String? selectedTheme = 'Light';
  String? selectedLang = 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme : ',
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
                color: Colors.white,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2)),
            child: Row(
              children: [
                Text(
                  selectedTheme ?? '',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
                const Spacer(),
                DropdownButton<String>(
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  items: <String>['Light', 'Dark'].map((String value) {
                    selectedTheme = value;
                    return DropdownMenuItem<String>(
                      value: selectedTheme,
                      child: Text(selectedTheme ?? ''),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme = newTheme;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Language : ',
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
                color: Colors.white,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2)),
            child: Row(
              children: [
                Text(
                  selectedLang ?? '',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
                const Spacer(),
                DropdownButton<String>(
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  items: <String>['English', 'Arabic'].map((String value) {
                    selectedLang = value;
                    return DropdownMenuItem<String>(
                      value: selectedLang,
                      child: Text(selectedLang ?? ''),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedLang = newTheme;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
