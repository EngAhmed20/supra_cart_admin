import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supra_cart_admin/core/helper_function/dummy_product_list.dart';
import 'package:supra_cart_admin/features/products/cubit/product_cubit.dart';
import 'package:supra_cart_admin/features/products/view/comments_view.dart';
import 'package:supra_cart_admin/features/products/view/edit_product_view.dart';
import 'package:supra_cart_admin/features/products/view/widget/product_card.dart';

import '../../../../core/style/app_text_styles.dart';

class ProductViewBody extends StatelessWidget {
  const ProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = context.read<ProductCubit>();
        if (state is GetProductLoading) {
          return Skeletonizer(
            child: ListView.separated(
              itemBuilder:
                  (context, index) => ProductCard(
                    productModel: dummyProductList[index],
                    editProductFun: () {},
                    viewProductFeedbackFun: () {},
                    deleteProductFun: () {},
                  ),
              separatorBuilder: (context, index) => Container(height: 5.h),
              itemCount: dummyProductList.length,
            ),
          );
        } else if (state is GetProductFailure) {
          return Center(child: Text(state.message, style: textStyle.Bold16));
        }
        return ListView.separated(
          itemBuilder:
              (context, index) => ProductCard(
                productModel: cubit.productList[index],
                editProductFun: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider.value(
                            value: context.read<ProductCubit>(),
                            child: EditProductView(
                              selectedProduct: cubit.productList[index],
                            ),
                          ),
                    ),
                  );
                },
                viewProductFeedbackFun: () {
                  Navigator.pushNamed(context, CommentsView.routeName);
                },
                deleteProductFun: () {},
              ),
          separatorBuilder: (context, index) => Container(height: 5.h),
          itemCount: cubit.productList.length,
        );
      },
      listener: (context, state) {},
    );
  }
}
