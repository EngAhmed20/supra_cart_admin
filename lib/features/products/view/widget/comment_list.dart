import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/core/models/comments_model.dart';
import 'package:supra_cart_admin/core/style/app_colors.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/custom_text_form.dart';

import '../../cubit/product_cubit.dart';
class CommentsList extends  StatelessWidget {
  const CommentsList({super.key, required this.comments});
  final List<CommentModel>comments;


  @override
  Widget build(BuildContext context) {
    final cubit=context.read<ProductCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child:ListView.separated(itemBuilder: (context,index){
        final replyController = TextEditingController();
        return CommentCard(
        commentModel:comments[index],
        replyController: replyController,
      replyFun: ()async{
          await cubit.addReply(reply: replyController.text, commentId: comments[index].id);
          }
      );},
        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
        itemCount: comments.length, // Replace with the actual number of comments
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,required this.commentModel, this.replyFun, required this.replyController,
  });
  final CommentModel commentModel;
  final  void Function()? replyFun;
  final TextEditingController replyController;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final GlobalKey<FormState>form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Card(
        elevation: 0.8,
        color: AppColors.kWhiteColor.withAlpha(125),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Comment: ${widget.commentModel.comments}',style: textStyle.Bold19,),
              SizedBox(height: 10.h,),
              Text((widget.commentModel.reply?.trim().isNotEmpty ?? false) ?'Reply: ${widget.commentModel.reply}':'',style: textStyle.Bold19,),
              SizedBox(height: 10.h,),
              if(widget.commentModel.reply?.trim().isEmpty ?? true)
                CustomTextFormField(hintText: 'Reply',controller: widget.replyController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your reply';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(onPressed: (){
                    if(form.currentState!.validate()){
                      widget.replyFun!();
                    }
                  },
                  icon:Icon(Icons.send,color: AppColors.kPrimaryColor,)),),

            ],
          ),
        ),

      ),
    );
  }
}