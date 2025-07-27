import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/features/auth/cubit/auth_cubit.dart';
import 'package:supra_cart_admin/features/home/view/home_view.dart';

import '../../../../core/helper_function/validators.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../core/widgets/custom_text_form.dart';
import '../../../../core/widgets/loadibg_ink_drop.dart';
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
    AutovalidateMode autovalidateMode =AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(builder: (context,state){
      var cubit = context.read<AuthCubit>();
      return state is AuthLoading?
           Loading_body(context):Form(
        key: loginForm,
        autovalidateMode: autovalidateMode,

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

                    SizedBox(height: 30.h),
                    LoginButton(
                      loginText: 'Login',
                      onTap: () {
                        if(loginForm.currentState!.validate()){
                          cubit.signIn(email: emailController.text,
                              password:passwordController.text);

                        }else{
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});

                        }
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
    }, listener: (context,state){
      if (state is AuthSuccess) {
        customSnackBar(
          context: context,
          msg: "Logged in successfully.",
          isError: false,
        );
        Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName, (route) => false);
      } else if (state is AuthFailure) {
        customSnackBar(context: context, msg: state.error);
      }

    });
  }
  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    autovalidateMode = AutovalidateMode.disabled;
    super.dispose();
  }
}
