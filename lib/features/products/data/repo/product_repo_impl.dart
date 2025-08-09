import 'dart:developer';

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

  @override
  Future<Either<Failure, void>> addProduct({required ProductModel product,required String token})async {
    try{
      final response=await apiServices.postData(path: productUrl,data: product.toJson(),token: token);
      return response.fold((failure)=>Left(Failure(message: failure.message)),(successResponse)=>Right(null));

    }catch(e){
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct({required ProductModel product, required String token}) async{

    try{
    final response=await apiServices.patchData(path:productUrl,
        queryParameters: {
      'product_id': 'eq.${product.id}',
        },
        data: product.toJson(),token: token);
    return response.fold(
      (failure)  {
        log('err from repo1 ${failure.message}');

        return Left(Failure(message: failure.message));},
      (successResponse) => Right(null),
    );
    }catch(e){
      log('err from repo ${e.toString()}');
      return Left(Failure(message: e.toString()));
    }
  }


}