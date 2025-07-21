import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/products/view/widget/comment_list.dart';

import '../../../core/widgets/custom_app_bar.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});
  static const String routeName = '/comments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Comments'),
      body: CommentsList()
    );
  }
}


