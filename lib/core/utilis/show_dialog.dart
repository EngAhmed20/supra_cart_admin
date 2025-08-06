import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_text_styles.dart';

Future<dynamic> customDialog({required BuildContext context, required String title,  required String content, required String actionText,required void Function() onAction}) {
  return showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text(title,style: textStyle.semiBold16,),
    content: Text(content,style: textStyle.regular16,),
    actions: [
      TextButton(onPressed:onAction,
        child:Text(actionText,style: textStyle.semiBold16,),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.red,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            Colors.white,
          ),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      )
    ],
  ));

}
