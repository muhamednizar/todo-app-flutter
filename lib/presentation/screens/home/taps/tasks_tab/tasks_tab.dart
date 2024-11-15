import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';

import '../../../../../database_manager/model/todo_dm.dart';
import '../../../../../database_manager/model/user_DM.dart';
import '../../../../providers/settings_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    readTodoFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: ColorsManager.blueColor,
              height: 100.h,
            ),
            buildCalender(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => TaskItem(
            todo: todosList[index],
            onDeletedOrEditTask: () {
              readTodoFromFireStore();
            },
          ),
          itemCount: todosList.length,
        ))
      ],
    );
  }

  buildCalender() {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    final unSelectedColor = settingsProvider.currentTheme == ThemeMode.light
        ? ColorsManager.whiteColor
        : ColorsManager.blackAccent;
    final unSelectedDayColor = settingsProvider.currentTheme == ThemeMode.light
        ? TextStyles.cardTitleTextStyle.copyWith(color: Colors.black)
        : TextStyles.cardTitleTextStyle.copyWith(color: Colors.white);

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            calenderSelectedDate = selectedDate;
            readTodoFromFireStore();
            //`selectedDate` the new date selected.
          },
          activeColor: ColorsManager.whiteColor,
          dayProps: EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              todayHighlightColor: const Color(0xffcddd79),
              activeDayStyle: const DayStyle(
                  dayNumStyle: TextStyle(
                      color: ColorsManager.blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  dayStrStyle: TextStyle(
                      color: ColorsManager.blueColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                  dayNumStyle: unSelectedDayColor,
                  decoration: BoxDecoration(
                      color: unSelectedColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))))),
          headerProps:
              EasyHeaderProps(monthPickerType: MonthPickerType.switcher),
        )
      ],
    );
  }

  readTodoFromFireStore() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    QuerySnapshot querySnapshot = await todoCollection
        .where("date",
            isEqualTo: calenderSelectedDate.copyWith(
              microsecond: 0,
              millisecond: 0,
              minute: 0,
              second: 0,
              hour: 0,
            )
            //filter date good way if you don't want hour , sec ,..
            )
        .get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map(
      (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromJson(json);
        return todo;
      },
    ).toList();
    setState(() {});
    //  //filter todos based on date
    //  todosList = todosList.where((todo) => todo.date.day == calenderSelectedDate.day,).toList();
    //  setState(() {
    //
    //  });
    //
  }
}
