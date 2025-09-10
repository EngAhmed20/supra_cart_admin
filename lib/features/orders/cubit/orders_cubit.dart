import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supra_cart_admin/core/models/purchase_with_product_model.dart';
import 'package:supra_cart_admin/features/orders/data/repo/order_repo.dart';

import '../../../core/utilis/constants.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.orderRepo) : super(OrdersInitial());
  final OrderRepo orderRepo;
  int currentPageIndex = 0;
  PageController pageController= PageController(initialPage: 0);
  onTapOnOrderType(int val){
    currentPageIndex=val;
    pageController.jumpToPage(val);
    emit(OnTapOnOrderTypeState());
  }
  List<PurchaseWithRelations>ordersList=[];
  List<PurchaseWithRelations>pendingOrders=[];
  List<PurchaseWithRelations>processingOrders=[];
  List<PurchaseWithRelations>shippedOrders=[];
  List<PurchaseWithRelations>deliveredOrders=[];
  Future<void>getAllOrders()async{
    clearOrdersList();
    emit(GetOrdersLoading());
    final result=await orderRepo.getOrders();
    result.fold((failure)=>emit(GetOrdersFailure(message: failure.message)),(orders){
      for(var order in orders) {
        ordersList.addAll(orders);
        if (order.purchase.orderStatus == orderStatusList[0]) {
          pendingOrders.add(order);
        } else if (order.purchase.orderStatus == orderStatusList[1]) {
          processingOrders.add(order);
        } else if (order.purchase.orderStatus == orderStatusList[2]) {
          shippedOrders.add(order);
        }else{
          deliveredOrders.add(order);
        }
      }
      emit(GetOrdersSuccess(orders: orders));
    });
  }
  void clearOrdersList(){
    ordersList.clear();
    pendingOrders.clear();
    processingOrders.clear();
    shippedOrders.clear();
    deliveredOrders.clear();
  }
}
