import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/core/widgets/loadibg_ink_drop.dart';
import 'package:supra_cart_admin/features/products/cubit/product_cubit.dart';
import 'package:supra_cart_admin/features/products/view/widget/comment_list.dart';

import '../../../core/widgets/custom_app_bar.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});
  static const String routeName = '/comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Comments'),
      body: BlocConsumer<ProductCubit,ProductState>(
       builder: (context,state){
         final cubit = context.read<ProductCubit>();
         if(state is GetProductCommentsLoading){
           return Loading_body(context);
         }else if(state is GetProductCommentsFailure){
           return Center(child: Text(state.message));
         }else if(cubit.productComments.isEmpty){
           return Center(child: Text('No comments yet',style: textStyle.Bold16,));
         }

          return CommentsList(comments: cubit.productComments);

       },
        listener: (context,state){

        },
      )
    );
  }
}


