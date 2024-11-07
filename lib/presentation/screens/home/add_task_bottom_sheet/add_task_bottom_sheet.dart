import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'add new task',
              textAlign: TextAlign.center,
              style: TextStyles.bottomSheetTitleTextStyle,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'enter task title',
                  hintStyle: TextStyles.hintTextStyle.copyWith(
                      fontWeight: FontWeight.w700, color: Color(0xFFA9A9A99C))),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'enter task description',
                  hintStyle: TextStyles.hintTextStyle.copyWith(
                      fontWeight: FontWeight.w700, color: Color(0xFFA9A9A99C))),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'select date',
              textAlign: TextAlign.center,
              style: TextStyles.hintTextStyle,
            ),
            InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Text(
                userSelectedDate.dateFormatted,
                textAlign: TextAlign.center,
                style: TextStyles.hintTextStyle.copyWith(
                    fontWeight: FontWeight.w900, color: Color(0xFFA9A9A99C)),
              ),
            ),
            Spacer(),
            MaterialButton(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  'Add Task',
                  style: TextStyles.registerBtnTextStyle
                      .copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        userSelectedDate;
    setState(() {});
  }
}
