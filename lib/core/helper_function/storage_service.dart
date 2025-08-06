import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';

abstract class StorageService{
  Future<Either<Failure,String>>uploadFile(File image);
}