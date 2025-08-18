import 'package:dartz/dartz.dart';
import 'failure.dart';

abstract class BaseApiServices{
  Future<Either<Failure, dynamic>> getData({required String path,Map<String, dynamic>? queryParameters,String?token});
  Future<Either<Failure, dynamic>> postData({required String path, Map<String, dynamic>? data,Map<String, dynamic>? queryParameters,String?token});
  Future<Either<Failure, dynamic>> patchData({required String path, Map<String, dynamic>? data,Map<String, dynamic>? queryParameters,String?token});
  Future<Either<Failure, dynamic>> deleteData({required String path,String? token,Map<String, dynamic>? queryParameters});
  Stream<Either<Failure,dynamic>>getStreamData({required String path,String? orderBy,
    bool descending = false,required String productId});


}