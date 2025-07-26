import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
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
 
  
}