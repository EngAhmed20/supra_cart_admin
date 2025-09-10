import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:supra_cart_admin/core/style/app_text_styles.dart';
import 'package:supra_cart_admin/features/orders/views/widget/order_item.dart';

import '../../../../core/models/purchase_with_product_model.dart';
import '../../cubit/orders_cubit.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, this.text, this.showButton= true, required this.ordersList, required this.cubit});
  final String? text;
  final bool? showButton;
  final List<PurchaseWithRelations> ordersList;
  final OrdersCubit cubit;




  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition:ordersList.isNotEmpty,
      builder: (context)=>ListView.builder(
        itemBuilder: (context,index)=>OrderItem(text: text,showButton: showButton, model: ordersList[index],cubit: cubit,),itemCount:ordersList.length,),
      fallback: (context)=>Center(child: Text('Nothing to show here',style: textStyle.Bold19,),),


    );
  }
}
