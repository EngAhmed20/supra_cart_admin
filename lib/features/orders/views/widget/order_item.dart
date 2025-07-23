import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_button.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/product_img.dart';
class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,this.text,this.showButton=true,
  });
final String? text;
final bool? showButton;
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
            Text('lenovo', style: textStyle.Bold20),
            Row(children: [
              ProductPicture(imgUrl:'https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740',),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RecipientIn formation:', style: textStyle.Bold18,),
                    SizedBox(height: 10.h),
                    Text('Name: Ahmed Mohamed', style: textStyle.regular16),
                    SizedBox(height: 5.h),
                    Text('Address: 123 Main St, Cairo', style: textStyle.regular16),
                    SizedBox(height: 5.h),
                    Text('Phone: +20 123 456 7890', style: textStyle.regular16),

                  ],
                ),
              ),

            ],),
            SizedBox(height: 10.h),
            Text('200 \EGP ', style: textStyle.Bold16),
            SizedBox(height: 10.h),
            if(showButton==true)
               CustomTextButton(onPressed: (){},text: text??'Preparing Order',style: textStyle.Bold19.copyWith(color: AppColors.kWhiteColor),),
            SizedBox(height: 10.h,),
          ],
        )
    );
  }
}
