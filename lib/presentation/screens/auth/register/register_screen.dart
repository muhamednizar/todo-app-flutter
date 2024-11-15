import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/utils/dialog/dialog.dart';

import '../../../../core/reusable_components/custom_text_form_field.dart';
import '../../../../core/strings_manager.dart';
import '../../../../core/utils/constant_manager.dart';
import '../../../../database_manager/model/user_DM.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fullNameController;

  late TextEditingController userNameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController rePasswordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: SvgPicture.asset(AssetsManager.routeLogo),
                ),
                Text(
                  'Full name',
                  style: TextStyles.registerLabelTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'enter your full name',
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz enter full name';
                    }
                    if (input.length < 6) {
                      return 'invalid full name,full name at least 6 char';
                    }
                    return null;
                  },
                  controller: fullNameController,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'username',
                  style: TextStyles.registerLabelTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'enter your username',
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz enter username';
                    }
                    return null;
                  },
                  controller: userNameController,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'e-mail',
                  style: TextStyles.registerLabelTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'enter your email',
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz enter email';
                    }
                    return null;
                  },
                  controller: emailController,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'password',
                  style: TextStyles.registerLabelTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'enter your password',
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz enter password';
                    }
                    if (input.length < 6) {
                      return 'sorry,password should be at least 6 char';
                    }
                    return null;
                  },
                  controller: passwordController,
                  isSecure: true,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  're-password',
                  style: TextStyles.registerLabelTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'confirm password',
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'plz enter password';
                    }
                    if (input.length < 6) {
                      return 'sorry,password should be at least 6 char';
                    }
                    return null;
                  },
                  controller: rePasswordController,
                  isSecure: true,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r)),
                        padding: REdgeInsets.symmetric(vertical: 11)),
                    onPressed: () {
                      register();
                    },
                    child: Text(
                      'Sign-Up',
                      style: TextStyles.registerBtnTextStyle,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have account? ',
                      style: TextStyles.registerLabelTextStyle,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesManager.loginRoute);
                        },
                        child: Text(
                          'Login now',
                          style: TextStyles.registerLabelTextStyle
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      // show Loading
      MyDialog.ShowLoading(context,
          loadingMessage: 'Waiting...', isDismissible: false);
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      addUserToFireStore(credential.user!.uid);
      //hide loading
      if (mounted) {
        MyDialog.hide(context);
      }
      // show success message
      if (mounted) {
        MyDialog.showMessage(context,
            body: 'User registered successfully',
            posActionTitle: 'Ok', posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
        });
      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        MyDialog.hide(context);
      }
      late String message;
      if (authError.code == ConstantManager.weakPassword) {
        message = StringsManager.weakPasswordMessage;
      } else if (authError.code == ConstantManager.emailInUse) {
        message = StringsManager.emailInUseMessage;
      }
      if (mounted) {
        MyDialog.showMessage(
          context,
          title: 'Error',
          body: message,
          posActionTitle: 'OK',
        );
      }
    } catch (error) {
      if (mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(context,
            title: 'Error',
            body: error.toString(),
            posActionTitle: 'Try again');
      }
    }
  }

  void addUserToFireStore(String uid) async {
    UserDM userDM = UserDM(
      id: uid,
      fullName: fullNameController.text,
      userName: userNameController.text,
      email: emailController.text,
    );
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    await userDocument.set(userDM.toFireStore());
  }
}
