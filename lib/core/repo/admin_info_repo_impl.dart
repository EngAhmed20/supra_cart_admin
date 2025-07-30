import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/core/models/admin_model.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import '../helper_function/base_api_services.dart';
class AdminInfoRepoImp implements AdminInfoRepo{
  BaseApiServices apiServices;
  AdminInfoRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, void>> addAdminInfo({required Map<String, dynamic>data}) async{
   try{
     var result=await apiServices.postData(path: adminTable,data: data);
      return result.fold(
        (failure) => Left(Failure(message: 'Failed to add admin info: ${failure.message}')),
        (response) {
          if(response.statusCode == 200 || response.statusCode == 201){
            return Right(null);
          } else {
            return Left(Failure(message: 'Failed to add admin info, please try again later'));
          }
        }
      );
     
   }catch(e){
     return Left(Failure(message: e.toString()));
   }
  }

  @override
  Future<Either<Failure, AdminModel>> getAdminInfo({required String adminId}) async{
    try{
      final response=await apiServices.getData(path: 'admin_table?id=eq.$adminId',);
      return response.fold(
        (failure) => Left(Failure(message: 'Failed to get admin info: ${failure.message}')),
        (data) {
          if(data is List && data.isNotEmpty){
            final adminModel = AdminModel.fromJson(data.first);
            print(adminModel.adminName);
            return Right(adminModel);
          } else {
            return Left(Failure(message: 'No admin info found'));
          }
        }
      );

    }catch(e){
      return Left(Failure(message: 'Failed to get admin info: ${e.toString()}'));
    }

  }
 
  
}