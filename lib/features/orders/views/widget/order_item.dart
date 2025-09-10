import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/models/purchase_with_product_model.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/product_img.dart';
class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,this.text,this.showButton=true, required this.model,
  });
final String? text;
final bool? showButton;
final PurchaseWithRelations model;
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
            Text(model.product.name, style: textStyle.Bold20),
            Row(children: [
              ProductPicture(imgUrl:model.product.imageUrl,),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RecipientIn formation:', style: textStyle.Bold18,),
                    SizedBox(height: 10.h),
                    Text('Name:${model.userModel.name}', style: textStyle.regular16),
                    SizedBox(height: 5.h),
                    if (model.deliveryInfoModel.isNotEmpty) ...[
                      Text(
                        'Address: '
                            '${model.deliveryInfoModel.first.additionalInfo ?? ''}, '
                            '${model.deliveryInfoModel.first.city}, '
                            '${model.deliveryInfoModel.first.governorate}',
                        style: textStyle.regular16,
                      ),
                      SizedBox(height: 5.h),
                      Text('Phone: ${model.deliveryInfoModel.first.mobilePhone}', style: textStyle.regular16),
                    ]
                    else ...[
                      Text('No delivery info available', style: textStyle.regular16),
                    ],

                  ],
                ),
              ),

            ],),
            SizedBox(height: 10.h),
            Text('${model.product.price} \EGP ', style: textStyle.Bold16),
            SizedBox(height: 10.h),
            if(showButton==true)
               CustomTextButton(onPressed: (){},text: model.purchase.orderStatus,style: textStyle.Bold19.copyWith(color: AppColors.kWhiteColor),),
            SizedBox(height: 10.h,),
          ],
        )
    );
  }
}
