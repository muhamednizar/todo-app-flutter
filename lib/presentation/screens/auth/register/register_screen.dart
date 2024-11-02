import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/routes_manager.dart';

import '../../../../core/reusable_components/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
              MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {},
                  child: Text(
                    'Register Now',
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
                        Navigator.pushNamed(context, RoutesManager.loginRoute);
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
    );
  }
}
