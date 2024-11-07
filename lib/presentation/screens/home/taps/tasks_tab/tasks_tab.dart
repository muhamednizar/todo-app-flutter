import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/task_item.dart';
import 'package:todo_app/core/utils/date_utils.dart';

class TasksTab extends StatelessWidget {
  TasksTab({super.key});

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          focusDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateChange: (selectedDate) {},
          itemBuilder: (context, date, isSelected, onTap) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorsManager.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.getDay,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? ColorsManager.blueColor
                            : Colors.black),
                  ),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? ColorsManager.blueColor
                            : Colors.black),
                  ),
                ],
              ),
            );
            ;
          },
        ),
        SizedBox(
          height: 20,
        ),
        TaskItem(),
      ],
    );
  }
}
