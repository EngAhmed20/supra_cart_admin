import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/style/app_colors.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';
class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child:ListView.separated(itemBuilder: (context,index)=>CommentCard(),
        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
        itemCount: 10, // Replace with the actual number of comments
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      color: AppColors.kWhiteColor.withAlpha(125),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('User Comment',style: textStyle.Bold18,),
            SizedBox(height: 10.h,),
            Text('Replay: This is a sample reply to the user comment.',style: textStyle.Bold19,),
            SizedBox(height: 10.h,),
            CustomTextFormField(hintText: 'Replay',suffixIcon: IconButton(onPressed: (){},
                icon:Icon(Icons.send,color: AppColors.kPrimaryColor,)),),

          ],
        ),
      ),

    );
  }
}