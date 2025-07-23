import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/widgets/custom_app_bar.dart';
import 'package:supra_cart_admin/features/orders/views/widget/orders_view_body.dart';
class OrdersView extends StatelessWidget {
  const OrdersView({super.key});
  static const String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Orders'),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
        child: OrdersViewBody(),
      ),
    );
  }
}

