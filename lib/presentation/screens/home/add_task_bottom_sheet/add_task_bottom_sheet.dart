import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';

import '../../../../database_manager/model/user_DM.dart';
import '../../../providers/settings_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AddTaskBottomSheet(),
      ),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height * .5,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.bottomSheetTitle,
                textAlign: TextAlign.center,
                style: settingsProvider.currentTheme == ThemeMode.light
                    ? TextStyles.TitleTextStyle
                    : TextStyles.TitleTextStyle.copyWith(
                        color: Colors.white,
                      ),
              ),
              TextFormField(
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'plz enter Task title';
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                settingsProvider.currentTheme == ThemeMode.light
                                    ? Colors.black38
                                    : Colors.white60)),
                    hintText:
                        AppLocalizations.of(context)!.bottomSheetTitleHint,
                    hintStyle: TextStyles.hintTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA9A9A99C))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return AppLocalizations.of(context)!.bottomSheetTitleHint;
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                settingsProvider.currentTheme == ThemeMode.light
                                    ? Colors.black38
                                    : Colors.white60)),
                    hintText: AppLocalizations.of(context)!
                        .bottomSheetDescriptionHint,
                    hintStyle: TextStyles.hintTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA9A9A99C))),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.bottomSheetDateSelect,
                textAlign: TextAlign.center,
                style: settingsProvider.currentTheme == ThemeMode.light
                    ? TextStyles.hintTextStyle
                    : TextStyles.hintTextStyle.copyWith(color: Colors.white),
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
                  onPressed: () {
                    addTodoToFireStore();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.bottomSheetAddTaskBtn,
                    style: TextStyles.registerBtnTextStyle
                        .copyWith(color: Colors.white),
                  ))
            ],
          ),
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

  void addTodoToFireStore() {
    if (formKey.currentState?.validate() == false) return;

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    CollectionReference todoCollection = usersCollection
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference doc = todoCollection.doc();

    TodoDM todo = TodoDM(
      id: doc.id,
      title: titleController.text,
      description: descriptionController.text,
      date: userSelectedDate.copyWith(
        microsecond: 0,
        millisecond: 0,
        minute: 0,
        second: 0,
        hour: 0,
      ),
      isDone: false,
    );

    doc
        .set(todo.toJson())
        .then(
          (_) {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        )
        .onError(
          (error, stackTrace) {},
        )
        .timeout(
          const Duration(seconds: 4),
          onTimeout: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        );
  }
}
