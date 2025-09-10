import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/orders/cubit/orders_cubit.dart';
import 'package:supra_cart_admin/features/orders/views/widget/order_item_list_view.dart';

class OrdersPageView extends StatelessWidget {
  const OrdersPageView({super.key, this.pageController, required this.cubit});
  final PageController? pageController;
  final OrdersCubit cubit;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(itemBuilder: (context,index){
      return ordersPagesList(cubit: cubit)[index];
    }, itemCount: ordersPagesList(cubit: cubit).length,
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      );
  }
  List<Widget>ordersPagesList({required OrdersCubit cubit}){
    return[
      OrdersListView(ordersList: cubit.ordersList,),
      OrdersListView(text: 'Shipped', ordersList: cubit.ordersList,),
      OrdersListView(text: 'Delivered', ordersList: cubit.ordersList,),
      OrdersListView(showButton: false, ordersList: cubit.ordersList,),
    ];
  }
}

