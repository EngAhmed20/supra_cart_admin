import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';

abstract class StorageService{
  Future<Either<Failure,String>>uploadFile(File image);
  Future<Either<Failure, String>> replaceFile({required String oldFileUrl,
    required File newImage,}) ;
  Future<Either<Failure, String>> deleteFile(String fileUrl);

}