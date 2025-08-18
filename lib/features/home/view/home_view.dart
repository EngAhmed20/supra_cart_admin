import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/helper_function/get_it_services.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/features/home/cubit/home_cubit.dart';
import 'package:supra_cart_admin/features/home/view/widgets/home_view_body.dart';

import '../../../core/helper_function/sign_out.dart';
import '../../../core/utilis/show_dialog.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt.get<SharedPreferences>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Supra Cart Admin', style: textStyle.Bold23),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            IconButton(
              onPressed: () {
                customDialog(context: context,
                  title: 'Log Out',
                  content: 'Are you sure you want to log out?',
                  actionText: 'Log Out',
                  onAction: () {
                    signOut(context, getIt.get<SharedPreferences>());
                  },
                );
              },
              icon: const Icon(Icons.logout_outlined, color: Colors.red),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: HomeViewBody(),
          ),
        ),
      ),
    );
  }
}
