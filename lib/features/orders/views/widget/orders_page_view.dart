import 'package:flutter/material.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import 'package:supra_cart_admin/features/orders/views/widget/order_item_list_view.dart';

class OrdersPageView extends StatelessWidget {
  const OrdersPageView({super.key, this.pageController});
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(itemBuilder: (context,index){
      return ordersPagesList(index)[index];
    }, itemCount: orderStatusList.length,
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      );
  }
}
List<Widget>ordersPagesList(index){
  return[
    OrdersListView(),
    OrdersListView(text: 'Shipped',),
    OrdersListView(text: 'Delivered',),
    OrdersListView(showButton: false,),
  ];
}