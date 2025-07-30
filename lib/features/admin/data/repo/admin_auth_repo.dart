import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/core/utilis/auth_response.dart';

abstract class AdminAuthRepo {
  Future<Either<Failure,String>>SignUp({required Map<String, dynamic> data});
    Future<Either<Failure,AuthResponse>>SignIn({required String email, required String password});
}