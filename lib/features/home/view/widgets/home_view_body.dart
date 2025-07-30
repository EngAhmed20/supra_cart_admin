import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import 'package:supra_cart_admin/features/admin/view/add_admin_view.dart';
import 'package:supra_cart_admin/features/home/cubit/home_cubit.dart';
import 'package:supra_cart_admin/features/products/view/add_product_view.dart';

import '../../../../core/helper_function/get_it_services.dart';
import '../../../admin/cubit/add_admin_cubit.dart';
import '../../../admin/data/repo/admin_auth_repo.dart';
import '../../../orders/views/orders_view.dart';
import '../../../products/view/product_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(builder: (context,state){
      var cubit = context.read<HomeCubit>();
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
                CustomTextButton(text: 'Orders', onPressed: () {
                  // Navigate to Orders view
                  Navigator.pushNamed(context, OrdersView.routeName);
                }),
                SizedBox(height: 15.h),
                CustomTextButton(text: 'Add Products', onPressed: () {
                  Navigator.pushNamed(context, AddProductView.routeName);
                }),
                SizedBox(height: 15.h),
             if( cubit.adminModel?.adminRole==adminRolesList[0])
                CustomTextButton(text: 'Add An Admin', onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AddAdminCubit(getIt.get<AdminAuthRepo>(),getIt.get<AdminInfoRepo>()),
                      child: AddAdminView(),
                    ),
                  ),
                );

              }),

              ],
            ),
          ),
        ),
      );
    });
  }
}
