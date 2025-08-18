import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/features/products/cubit/product_cubit.dart';
import 'package:supra_cart_admin/features/products/view/comments_view.dart';
import 'package:supra_cart_admin/features/products/view/edit_product_view.dart';
import 'package:supra_cart_admin/features/products/view/widget/product_card.dart';
import '../../../../core/helper_function/get_it_services.dart';
import '../../../../core/helper_function/sign_out.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/utilis/show_dialog.dart';
import '../../../../core/widgets/custom_search_filed.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../core/widgets/product_skeletonizer.dart';

class ProductViewBody extends StatelessWidget {
  const ProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final searchForm = GlobalKey<FormState>();
    return BlocConsumer<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = context.read<ProductCubit>();
       final productToDisplay=
        cubit.searchController.text.isNotEmpty
            ? cubit.searchResults
            : cubit.productList;
        return Form(
          key: searchForm,
          child: Column(
            children: [
              CustomSearchField(hintText: 'Search in Market',
                controller: cubit.searchController,
                onChanged: (val){
                if(val.isEmpty){
                  cubit.clearSearch();
                }
                },

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a search term';
                  }
                  return null;
                },
                searchAction: (){
                  cubit.searchButton(context,searchForm: searchForm);

                },),
              SizedBox(height: 10.h,),
              Expanded(child: (){
                if (state is GetProductLoading||state is DeleteProductLoading||
                    state is SearchProductLoading) {
                  return customProductSkeletonizer();
                } else if (state is GetProductFailure) {
                  return Center(child: Text(state.message, style: textStyle.Bold16));
                } else if (state is SearchProductFailure) {
                  return Center(child: Text(state.message, style: textStyle.Bold16));
                }
                return ListView.separated(
                  itemBuilder:
                      (context, index) => ProductCard(
                    productModel: productToDisplay[index],
                    editProductFun: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider.value(
                            value: context.read<ProductCubit>(),
                            child: EditProductView(
                              selectedProduct: productToDisplay[index],
                            ),
                          ),
                        ),
                      );
                    },
                    viewProductFeedbackFun: () {
                      Navigator.pushNamed(context, CommentsView.routeName);
                    },
                    deleteProductFun: () {
                      customDialog(
                        context: context,
                        title: 'Delete Product',
                        content: 'Are you sure you want to delete this product?',
                        actionText: 'Delete',
                        onAction: () {
                          cubit.removeProduct(productId: productToDisplay[index].id!,
                              productImgUrl: productToDisplay[index].imageUrl);
                          Navigator.pop(context);
                        },
                      );

                    },
                  ),
                  separatorBuilder: (context, index) => Container(height: 5.h),
                  itemCount: productToDisplay.length,
                );
              }()),


            ],
          ),
        );

      },
      listener: (context, state) {
        if (state is DeleteProductSuccess) {
          customSnackBar(
            context: context,
            msg: "Product deleted successfully",
            isError: false,
          );
        } else if (state is DeleteProductFailure) {
          customSnackBar(
            context: context,
            msg: 'Failed to delete product,Try Again',
          );
        }
        else if (state is AccessTokenExpired) {
          customDialog(context: context,
            title: 'Session Expired',
            content: 'Your session has expired. please log in again',
            actionText: 'Log Out',
            onAction: () {
              signOut(context, getIt.get<SharedPreferences>());
            },
          );
        }

      },
    );
  }

}
