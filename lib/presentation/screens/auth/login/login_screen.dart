import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/config/theme/text_styles.dart';
import 'package:todo_app/core/assets_manager.dart';

import '../../../../core/reusable_components/custom_text_form_field.dart';
import '../../../../core/routes_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController passwordController = TextEditingController();
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
                  onPressed: () {},
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
}
