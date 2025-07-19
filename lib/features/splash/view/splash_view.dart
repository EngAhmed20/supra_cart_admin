import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/auth/view/login_view.dart';

import '../../../generated/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    executeNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child:
          Image.asset(Assets.imgSupraLogo),


      ),
    );
  }

  void executeNavigation() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route)=>false);

    });
  }
}
/*void executeNavigation() {
  Future.delayed(const Duration(seconds: 3), () {
    getIt.get<SupabaseClient>().auth.currentUser!=null
        ?Navigator.pushNamedAndRemoveUntil(context, MainHomeView.routeName, (route) => false)
        :
    Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);

  });
}*/