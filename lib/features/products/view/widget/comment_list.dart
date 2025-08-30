import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/models/comments_model.dart';
import 'package:supra_cart_admin/core/style/app_colors.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';
class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.comments});
  final List<CommentModel>comments;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child:ListView.separated(itemBuilder: (context,index)=>CommentCard(
        commentModel: comments[index],
      replyFun: (){
          // add your reply function here
      },),
        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
        itemCount: comments.length, // Replace with the actual number of comments
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,required this.commentModel, this.replyFun,
  });
  final CommentModel commentModel;
  final  void Function()? replyFun;

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
            Text(commentModel.comments,style: textStyle.Bold18,),
            SizedBox(height: 10.h,),
            Text(commentModel.reply??'Replay: This is a sample reply to the user comment.',style: textStyle.Bold19,),
            SizedBox(height: 10.h,),
            CustomTextFormField(hintText: 'Replay',suffixIcon: IconButton(onPressed: replyFun,
                icon:Icon(Icons.send,color: AppColors.kPrimaryColor,)),),

          ],
        ),
      ),

    );
  }
}