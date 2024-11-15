import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_DM.dart';

import '../../../../config/theme/text_styles.dart';
import '../../../../core/colors_manager.dart';
import '../../../providers/settings_provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.todo});

  final TodoDM todo;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController editTitleController = TextEditingController();

  TextEditingController editDescriptionController = TextEditingController();
  List<TodoDM> todosList = [];

  var formKey = GlobalKey<FormState>();

  @override
  // void initState() {
  //   super.initState();
  //   // TODO: implement initState
  //   editTaskToFirestore();
  // }
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        toolbarHeight: 70.h,
      ),
      body: Center(
        child: Container(
          width: 350.w,
          height: 500.h,
          decoration: BoxDecoration(
            color: settingsProvider.currentTheme == ThemeMode.light
                ? ColorsManager.whiteColor
                : ColorsManager.blackAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppLocalizations.of(context)!.editTask,
                    style: settingsProvider.currentTheme == ThemeMode.light
                        ? TextStyles.TitleTextStyle
                        : TextStyles.TitleTextStyle.copyWith(
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.editTitleHint;
                      }
                      return null;
                    },
                    controller: editTitleController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsProvider.currentTheme ==
                                        ThemeMode.light
                                    ? Colors.black38
                                    : Colors.white60)),
                        hintText: AppLocalizations.of(context)!.editTitleHint,
                        hintStyle: TextStyles.hintTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA9A9A99C))),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .editDescriptionHint;
                      }
                      return null;
                    },
                    controller: editDescriptionController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: settingsProvider.currentTheme ==
                                        ThemeMode.light
                                    ? Colors.black38
                                    : Colors.white60)),
                        hintText:
                            AppLocalizations.of(context)!.editDescriptionHint,
                        hintStyle: TextStyles.hintTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA9A9A99C))),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  MaterialButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        editTaskToFirestore();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.editBtn,
                        style: TextStyles.registerBtnTextStyle
                            .copyWith(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void editTaskToFirestore() {
    if (formKey.currentState!.validate() == false) return;

    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    todoCollection.doc(widget.todo.id).update({
      'title': editTitleController.text,
      'description': editDescriptionController.text
    });

    Navigator.pop(context);
  }
}
