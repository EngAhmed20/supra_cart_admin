import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.style,  this.text, this.radius, required this.onPressed, this.backgroundColor, this.verticalPadding, this.horizontalPadding, this.child, this.width});
  final String? text;
  final double? radius;
  final TextStyle? style;
  final Color?backgroundColor;
  final double?verticalPadding;
  final double?horizontalPadding;
  final void Function() onPressed;
  final Widget? child;
  final double? width;



  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? AppColors.kPrimaryColor,
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              vertical: verticalPadding ?? 10,
              horizontal: horizontalPadding ?? 10,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
            ),
          ),
        ),
        child: child ??
            Text(
              text!,
              style:
              style ?? textStyle.Bold24.copyWith(color: AppColors.kWhiteColor),
            ),
      ),
    );
  }
}
