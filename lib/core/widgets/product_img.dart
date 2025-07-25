import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cached_img.dart';
import 'loadibg_ink_drop.dart';

class ProductPicture extends StatelessWidget {
  const ProductPicture({
    super.key, required this.imgUrl, this.height, this.width,
  });
  final String imgUrl;
   final double? height;
    final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      child: CachedImg(
        imgUrl:imgUrl,
        height: height,
        width: width,
        placeHolder: Container(
          width: double.infinity,
          height: 150.h,
          child: Center(child: LoadingInkDrop()),
        ),
      ),
    );
  }
}
