import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';

ElevatedButton customElevatedButton({required void Function() onPressed,required IconData icon,Color?iconColor,Color? backgroundColor}) {
  return ElevatedButton(onPressed: onPressed,
      child:
      Icon(icon,color: iconColor??Colors.white,size: 25.sp,)
      ,style:ElevatedButton.styleFrom(
        backgroundColor: backgroundColor??AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ));
}
