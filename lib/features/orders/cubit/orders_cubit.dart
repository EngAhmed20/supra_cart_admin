import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supra_cart_admin/core/models/purchase_with_product_model.dart';
import 'package:supra_cart_admin/features/orders/data/repo/order_repo.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.orderRepo) : super(OrdersInitial());
  final OrderRepo orderRepo;
  List<PurchaseWithRelations>ordersList=[];
  int currentPageIndex = 0;
  PageController pageController= PageController(initialPage: 0);
  onTapOnOrderType(int val){
    currentPageIndex=val;
    pageController.jumpToPage(val);
    emit(OnTapOnOrderTypeState());
  }
  Future<void>getAllOrders()async{
    ordersList.clear();
    emit(GetOrdersLoading());
    final result=await orderRepo.getOrders();
    result.fold((failure)=>emit(GetOrdersFailure(message: failure.message)),(orders){
      ordersList.addAll(orders);
      emit(GetOrdersSuccess(orders: orders));
    });
  }
}
