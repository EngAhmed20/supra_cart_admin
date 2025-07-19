import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/auth/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key?key}) : super(key: key);
  static const String  routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: LoginViewBody(),
        ),
      ),
    );
  }
}
