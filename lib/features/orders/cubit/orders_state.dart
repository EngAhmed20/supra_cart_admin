part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}
class UpdateOrderStatusLoading extends OrdersState {}
class UpdateOrderStatusSuccess extends OrdersState {}
class UpdateOrderStatusFailure extends OrdersState {
  final String message;
  UpdateOrderStatusFailure({required this.message});
}
class GetOrdersLoading extends OrdersState {}
class GetOrdersSuccess extends OrdersState {
    final List<PurchaseWithRelations> orders;
  GetOrdersSuccess({required this.orders});
}
class GetOrdersFailure extends OrdersState {
  final String message;
  GetOrdersFailure({required this.message});
}
class OnTapOnOrderTypeState extends OrdersState {}

