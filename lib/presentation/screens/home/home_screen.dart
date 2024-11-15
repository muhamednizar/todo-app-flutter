import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/taps/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/taps/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
int selectedIndex = 0;
List<Widget> tabs = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      SettingsTab()
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleApp),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await AddTaskBottomSheet.show(context);
          tasksTabKey.currentState?.readTodoFromFireStore();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.list,
                ),
                label: AppLocalizations.of(context)!.tasksTab),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                label: AppLocalizations.of(context)!.settingsTab),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
