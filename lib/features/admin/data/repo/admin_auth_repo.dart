import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';

abstract class AdminAuthRepo {
  Future<Either<Failure,void>>SignUp({required Map<String, dynamic> data});
  Future<Either<Failure,void>>SignIn({required String email, required String password});
}