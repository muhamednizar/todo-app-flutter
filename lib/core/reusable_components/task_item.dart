import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_DM.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.todo, required this.onDeletedOrEditTask});

  TodoDM todo;
  Function onDeletedOrEditTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).indicatorColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: REdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              onPressed: (context) {
                deleteTodoFromFireStore(todo);
                onDeletedOrEditTask();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              onPressed: (context) async {
                await Navigator.pushNamed(
                  context,
                  RoutesManager.editRoute,
                  arguments: todo,
                );
                onDeletedOrEditTask();
              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: todo.isDone
                      ? Colors.green
                      : Theme.of(context).dividerColor,
                  height: 62,
                  width: 3,
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: todo.isDone
                          ? TextStyles.cardTitleTextStyle.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: ColorsManager.successColor,
                            )
                          : TextStyles.cardTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.description_outlined),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          todo.description,
                          style: todo.isDone
                              ? Theme.of(context).textTheme.bodySmall?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  )
                              : Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 69,
                  height: 43,
                  decoration: BoxDecoration(
                    color: todo.isDone
                        ? ColorsManager.successColor
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(
                      todo.isDone ? Icons.done_all : Icons.check,
                      color: ColorsManager.whiteColor,
                      size: 30,
                    ),
                    onPressed: () async {
                      await TodoComplete(todo);
                      onDeletedOrEditTask();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTodoFromFireStore(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.delete();
  }

  Future<void> TodoComplete(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    DocumentReference todoDoc = todoCollection.doc(todo.id);

    await todoDoc.update({'isDone': !todo.isDone});
  }
}
