import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/features/home/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Supra Cart Admin',style: textStyle.Bold23,),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout_outlined,color: Colors.red,),
          ),
        ],
      ),
      body: SafeArea(child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        child: HomeViewBody(),
      )),
    );
  }
}
