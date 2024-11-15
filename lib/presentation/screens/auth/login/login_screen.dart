import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/assets_manager.dart';

import '../../../../core/reusable_components/custom_text_form_field.dart';
import '../../../../core/routes_manager.dart';
import '../../../../core/strings_manager.dart';
import '../../../../core/utils/constant_manager.dart';
import '../../../../core/utils/dialog/dialog.dart';
import '../../../../database_manager/model/user_DM.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70),
                child: SvgPicture.asset(AssetsManager.routeLogo),
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot password',
                    style: TextStyles.registerLabelTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    'Login',
                    style: TextStyles.registerBtnTextStyle,
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account? ',
                    style: TextStyles.registerLabelTextStyle,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesManager.registerRoute);
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyles.registerLabelTextStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      // show Loading
      MyDialog.ShowLoading(context,
          loadingMessage: 'Waiting...', isDismissible: false);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.currentUser = await readUserFromFireStore(credential.user!.uid);

      //hide loading
      if (mounted) {
        MyDialog.hide(context);
      }
      // show success message
      if (mounted) {
        MyDialog.showMessage(context,
            body: 'User Logged in successfully',
            posActionTitle: 'Ok', posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
        });
      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        MyDialog.hide(context);
      }

      String message = "An error occurred. Please try again.";

      if (authError.code == ConstantManager.invalidCredential) {
        message = StringsManager.wrongEmailOrPasswordMessage;
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

  Future<UserDM> readUserFromFireStore(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    DocumentSnapshot userDocumentSnapshot = await userDocument.get();
    Map<String, dynamic> json =
        userDocumentSnapshot.data() as Map<String, dynamic>;
    UserDM userDM = UserDM.fromFireStore(json);
    return userDM;
  }
}
