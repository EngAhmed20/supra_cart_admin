import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/core/models/purchase_with_product_model.dart';
import 'package:supra_cart_admin/features/orders/data/repo/order_repo.dart';

import '../../../../core/helper_function/base_api_services.dart';

class OrderRepoImpl implements OrderRepo {
  BaseApiServices apiServices;
  OrderRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<PurchaseWithRelations>>> getOrders() async{
try{
  final response= await apiServices.getData(path: 'purchase_table?select=*,products_table(*),users(*,delivery_info(*))');
  return response.fold((failure)=>Left(Failure(message: failure.message)),(data){
    final dataList= data as List;
    final orders=dataList.map((e)=>PurchaseWithRelations.fromJson(e)).toList();
    return Right(orders);
  });

}catch(e){
  return Left(Failure(message: e.toString()));
}
}

  @override
  Future<Either<Failure, void>> deleteOrder({required String orderId}) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus({required String orderId, required String status}) {
    // TODO: implement updateOrderStatus
    throw UnimplementedError();
  }
  

}