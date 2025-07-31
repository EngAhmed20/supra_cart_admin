import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/base_api_services.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/core/models/product_model.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import 'package:supra_cart_admin/features/products/data/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final BaseApiServices apiServices;

  ProductRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts([String?token]) async{
   var result=await apiServices.getData(path: productUrl,token: token);
   return result.fold((failure)=>Left(Failure(message: failure.message)),(successResponse){
    final data=successResponse as List;
    if(data.isNotEmpty){
      List<ProductModel>productList=data.
      map((e)=>ProductModel.fromJson(e)).toList();
      return Right(productList);

    }else{
      return Left(Failure(message: 'No products found'));
    }
   });



  }


}