import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/orders/views/widget/order_item.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, this.text, this.showButton= true});
  final String? text;
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context,index)=>OrderItem(text: text,showButton: showButton,),itemCount: 10,);
  }
}
