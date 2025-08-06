import 'package:flutter/material.dart';

Future<dynamic> customDialog({required BuildContext context, required String title,  required String content, required String actionText,required void Function() onAction}) {
  return showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text(title??'Session Expired'),
    content: Text(content??'Your session has expired. please log in again'),
    actions: [
      TextButton(onPressed: onAction, child:Text(actionText))
    ],
  ));
}
