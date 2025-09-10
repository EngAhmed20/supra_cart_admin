import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/orders/views/widget/order_item.dart';

import '../../../../core/models/purchase_with_product_model.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, this.text, this.showButton= true, required this.ordersList});
  final String? text;
  final bool? showButton;
  final List<PurchaseWithRelations> ordersList;



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context,index)=>OrderItem(text: text,showButton: showButton, model: ordersList[index],),itemCount:ordersList.length,);
  }
}
