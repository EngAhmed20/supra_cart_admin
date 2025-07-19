import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/auth/view/login_view.dart';
import 'package:supra_cart_admin/features/splash/view/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());

    default:
      return MaterialPageRoute(builder: (_) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ));
  }
}