import 'package:dartz/dartz.dart';

import '../helper_function/failure.dart';


abstract class AdminInfoRepo  {
  Future<Either<Failure, void>> addAdminInfo({required Map<String,dynamic>data});

}
