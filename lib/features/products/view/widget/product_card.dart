import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/style/app_colors.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/product_img.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productImg, required this.productName, required this.productDescription, required this.productPrice, this.productOldPrice, required this.editProductFun, required this.viewProductFeedbackFun, required this.deleteProductFun});
  final String productImg;
  final String productName;
  final String productDescription;
  final double productPrice;
  final double? productOldPrice;
  final void Function() editProductFun;
  final void Function() viewProductFeedbackFun;
  final void Function() deleteProductFun;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.3,
        color: AppColors.kGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              ProductPicture(imgUrl:productImg,),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productName, style: textStyle.Bold19),
                    SizedBox(height: 5.h),
                    Text(productDescription, style: textStyle.regular16,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),

            ],),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Text('$productPrice \EGP ', style: textStyle.Bold16),
                if (productOldPrice != null)
                    Text('$productOldPrice \EGP', style: textStyle.regular16.copyWith(decoration: TextDecoration.lineThrough),),


              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customElevatedButton(onPressed:editProductFun, icon: Icons.edit,iconColor: Colors.white,backgroundColor: AppColors.kPrimaryColor),
                  SizedBox(width: 10.w),
                  customElevatedButton(onPressed:viewProductFeedbackFun, icon: Icons.comment,iconColor: Colors.white,backgroundColor: AppColors.kPrimaryColor),
                  SizedBox(width: 10.w),
                  customElevatedButton(onPressed:deleteProductFun, icon: Icons.delete,iconColor: Colors.red,backgroundColor: AppColors.kWhiteColor),

                ],
              ),

            ),
            SizedBox(height: 10.h,),
          ],
        )
    );
  }
}
