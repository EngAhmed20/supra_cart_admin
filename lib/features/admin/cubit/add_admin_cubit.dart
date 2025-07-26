import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:supra_cart_admin/features/admin/data/repo/add_admin_repo.dart';

part 'add_admin_state.dart';

class AddAdminCubit extends Cubit<AddAdminState> {
  AddAdminCubit(this.addAdminRepo) : super(AddAdminInitial()){}
  final AddAdminRepo addAdminRepo;
  Future<void> signUp({required String email,required String password}) async {
    emit(AddAdminLoading());
    final result = await addAdminRepo.SignUp(data: {
      "email":email,
      "password":password

    });
    result.fold(
      (failure) => emit(AddAdminFailure(error: failure.message)),
      (success) => emit(AddAdminSuccess()),
    );
  }
}
