import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/colors_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor,
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      child: Slidable(
        startActionPane:
            ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            onPressed: (context) {},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        endActionPane:
            ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            onPressed: (context) {},
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ]),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 62,
                  width: 3,
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Text('Task Title', style: TextStyles.cardTitleTextStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(
                          width: 7,
                        ),
                        Text('10:30',
                            style: Theme.of(context).textTheme.bodySmall)
                      ],
                    )
                  ],
                ),
                Spacer(),
                Container(
                    width: 69,
                    height: 43,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.check,
                      color: ColorsManager.whiteColor,
                      size: 30,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
