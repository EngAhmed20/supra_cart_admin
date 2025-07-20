import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';

import '../../../products/view/product_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        color: Colors.white.withAlpha(188),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextButton(text: 'Products', onPressed: () {
                Navigator.pushNamed(context, ProductView.routeName);
              }),
              SizedBox(height: 15.h),
              CustomTextButton(text: 'Orders', onPressed: () {}),
              SizedBox(height: 15.h),
              CustomTextButton(text: 'Add Products', onPressed: () {}),
              SizedBox(height: 15.h),
              CustomTextButton(text: 'Add An Admin', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
