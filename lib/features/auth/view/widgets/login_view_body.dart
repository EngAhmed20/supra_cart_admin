import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper_function/validators.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form.dart';
import 'login_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
   GlobalKey<FormState> loginForm= GlobalKey<FormState>();
   TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginForm,
      child: Column(
        children: [
           SizedBox(height: 30.h),
          Text('Welcome to Supra Dashboard', style: textStyle.Bold24),
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Card(
            margin: EdgeInsets.zero,
            color: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 30.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      return FormValidators.validateEmail(value);
                    },
                  ),
                   SizedBox(height: 25.h),
                  CustomTextFormField(
                    hintText: 'Enter your password',
                    isPassword: true,
                    controller: passwordController,
                    obscureText: true,
                    onTogglePasswordVisibility: () {
                      //cubit.changePasswordVisibility();
                    },
                    validator: (value) {
                      return FormValidators.validatePassword(value);
                    },
                  ),
                   SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        /*Navigator.pushNamed(
                          context,
                        );*/
                      },
                      child: Text(
                        'Forgot Password?',
                        style: textStyle.semiBold16.copyWith(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 30.h),
                  LoginButton(
                    loginText: 'Login',
                    onTap: () {
                      //cubit.loginButtonPressed();
                    },
                  ),
                ],
              ),
            ),
          ),

          //Spacer(flex: 2,),
        ],
      ),
    );
  }
  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
