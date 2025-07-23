import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart_admin/features/orders/views/widget/order_type_title.dart';
class OrdersTypeList extends StatelessWidget {
  const OrdersTypeList({super.key, required this.currentPageIndex, required this.onOrderTypeSelected});
  final int currentPageIndex;
  final Function(int) onOrderTypeSelected;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(itemBuilder: (context,index)=>GestureDetector(
        onTap: () {
          onOrderTypeSelected(index);
        },
        child: OrdersTypeTitle(title: getTitle()[index],
            index: (index+1).toString(), isActive: index<=currentPageIndex),
      ),
        itemCount: getTitle().length,scrollDirection: Axis.horizontal,
      ),
    );
  }
}
List<String> getTitle() {
  return [
    'New Orders',
    'Processing Orders',
    'Shipped Orders',
    'Delivered Orders',
  ];
}