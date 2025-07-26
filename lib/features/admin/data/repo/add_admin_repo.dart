import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';

abstract class AddAdminRepo {
  Future<Either<Failure,void>>SignUp({required Map<String, dynamic> data});
}