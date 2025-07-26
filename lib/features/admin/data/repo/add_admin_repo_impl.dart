import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/base_api_services.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/features/admin/data/repo/add_admin_repo.dart';

class AddAdminRepoImpl implements AddAdminRepo{
  BaseApiServices baseApiServices;
  AddAdminRepoImpl({required this.baseApiServices});
  @override
  Future<Either<Failure, void>> SignUp({required Map<String, dynamic>data}) async{
    try{
      var result=await baseApiServices.postData(path: 'signup',data: data);
      return result.fold((failure)=>Left(Failure(message: failure.message.toString())),
          (response){
        if(response.statusCode==200){
          return Right(null);
        }else{
          return Left(Failure(message: 'Failed to sign up, please try again later'));
        }

          });


    }catch(e){
      print(e.toString());
      return Left(Failure( message:e.toString()));
    }

  }

}