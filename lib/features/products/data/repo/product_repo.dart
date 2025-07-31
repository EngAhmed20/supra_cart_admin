import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/core/models/product_model.dart';

abstract class ProductRepo{
  Future<Either<Failure,List<ProductModel>>> getAllProducts([String? token]);

}