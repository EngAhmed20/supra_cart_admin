import 'package:flutter/material.dart';
import 'package:supra_cart_admin/core/widgets/loadibg_ink_drop.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
   const CustomTextButton({super.key, this.style,  this.text, this.radius,this.isLoading=false, required this.onPressed, this.backgroundColor, this.verticalPadding, this.horizontalPadding, this.child, this.width});
  final String? text;
  final double? radius;
  final TextStyle? style;
  final Color?backgroundColor;
  final double?verticalPadding;
  final double?horizontalPadding;
  final void Function() onPressed;
  final Widget? child;
  final double? width;
  final bool isLoading ;



  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: isLoading?LoadingInkDrop():TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            backgroundColor ?? AppColors.kPrimaryColor,
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              vertical: verticalPadding ?? 10,
              horizontal: horizontalPadding ?? 10,
            ),
          ),
          shape: WidgetStateProperty.all<OutlinedBorder>(
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
      )
    );
  }
}
