import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/orders/views/widget/orders_page_view.dart';
import 'order_type_title_list.dart';
class OrdersViewBody extends StatefulWidget {
  const OrdersViewBody({super.key});

  @override
  State<OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<OrdersViewBody> {
  int currentPageIndex = 0;
  PageController pageController= PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: OrdersTypeList(currentPageIndex: currentPageIndex,onOrderTypeSelected: (val){
            currentPageIndex=val;
            pageController.jumpToPage(val);
            setState(() {

            });
          },),
        ),
        SliverFillRemaining(
         child: OrdersPageView(pageController: pageController,),
       ),

      ],
    );
  }
}
