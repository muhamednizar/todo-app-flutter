import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/taps/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/taps/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedIndex = 0;
List<Widget> tabs = [TasksTab(), SettingsTab()];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('ToDoList'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddTaskBottomSheet.show(context);
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
