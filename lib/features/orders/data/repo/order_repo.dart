import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/core/models/purchase_with_product_model.dart';

abstract class OrderRepo{
  Future<Either<Failure,void>> updateOrderStatus({required String orderId, required String status,});
  Future<Either<Failure,void>> deleteOrder({required String orderId,});
  Future<Either<Failure,List<PurchaseWithRelations>>> getOrders();
}