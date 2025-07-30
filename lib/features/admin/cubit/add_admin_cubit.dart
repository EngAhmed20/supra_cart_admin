import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo.dart';

part 'add_admin_state.dart';

class AddAdminCubit extends Cubit<AddAdminState> {
  AddAdminCubit(this.addAdminRepo,this.adminInfoRepo) : super(AddAdminInitial());
  final AdminAuthRepo addAdminRepo;
  final AdminInfoRepo adminInfoRepo;
  Future<void> signUp({required String email,required String password,required String name,required String role}) async {
    emit(AddAdminLoading());
    final result = await addAdminRepo.SignUp(data: {
      "email":email,
      "password":password

    });
     result.fold(
      (failure) => emit(AddAdminFailure(error: failure.message)),
      (adminId)async{

        await addAdminInfo(name: name,email: email,role: role,id:adminId );
        emit(AddAdminSuccess());
      },
    );
  }
  Future<void> addAdminInfo({required String name,required String email,required String id,required String role}) async {
    final result = await adminInfoRepo.addAdminInfo(data: {
      'admin_name':name,
      'admin_email': email,
      'admin_role':role,
      'id':id
    });
    result.fold(
      (failure) => emit(AddAdminInfoFailure(error: failure.message)),
      (success) => emit(AddAdminInfoSuccess()),
    );
  }
}
