import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/models/admin_model.dart';

import '../helper_function/failure.dart';


abstract class AdminInfoRepo  {
  Future<Either<Failure, void>> addAdminInfo({required Map<String,dynamic>data});
  Future<Either<Failure, AdminModel>> getAdminInfo({required String adminId});


}
