import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../generated/assets.dart';

class ActiveStepItem extends StatelessWidget {
  const ActiveStepItem({
    super.key, required this.title,
  });
  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            width: 25,
            height: 25,
            child: CircleAvatar(
              backgroundColor: AppColors.kPrimaryColor,
              child: SvgPicture.asset(
                Assets.imgCheck
              )
            ),
          ),
          const SizedBox(width: 5,),
          Text(
            title,
            style: textStyle.Bold16.copyWith(color: AppColors.kPrimaryColor),
          ),
        ],),
    );
  }
}
