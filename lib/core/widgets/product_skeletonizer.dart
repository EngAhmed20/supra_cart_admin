import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../features/products/view/widget/product_card.dart';
import '../helper_function/dummy_product_list.dart';

Skeletonizer customProductSkeletonizer() {
  return Skeletonizer(
    child: ListView.separated(
      itemBuilder:
          (context, index) => ProductCard(
        productModel: dummyProductList[index],
        editProductFun: () {},
        viewProductFeedbackFun: () {},
        deleteProductFun: () {},
      ),
      separatorBuilder: (context, index) => Container(height: 5.h),
      itemCount: dummyProductList.length,
    ),
  );
}
