import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
                width: 58,
                height: 85,
                dayStructure: DayStructure.dayStrDayNum,
                activeDayStyle: DayStyle(
                  dayStrStyle:
                      TextStyle(fontSize: 18, color: ColorsManager.blueColor),
                  dayNumStyle: TextStyle(
                      fontSize: 18,
                      color: ColorsManager.blueColor,
                      fontWeight: FontWeight.w700),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     Colors.white,
                      //     Colors.white12,
                      //   ],
                      // ),
                      color: Colors.white),
                ),
                inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          TaskItem(),
        ],
      ),
    );
  }
}
