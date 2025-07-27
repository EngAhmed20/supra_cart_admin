import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/helper_function/base_api_services.dart';
import 'package:supra_cart_admin/core/helper_function/failure.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo.dart';

class AdminAuthRepoImpl implements AdminAuthRepo{
  BaseApiServices baseApiServices;
  AdminAuthRepoImpl({required this.baseApiServices});
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

  @override
  Future<Either<Failure, void>> SignIn({required String email,required String password}) async{
    try{
      var result=await baseApiServices.postData(path: 'token',data: {
        "email": email,
        "password": password
      },queryParameters:{
        "grant_type": "password"

      });
      return result.fold((failure) => Left(Failure(message: failure.message.toString())),
          (response) {
        if(response.statusCode==200){
          return Right(null);
        }else{
          return Left(Failure(message: 'Failed to sign in, please try again later'));
        }
      });
      
    }catch(e){
      return Left(Failure(message: e.toString()));
    }
  }


}