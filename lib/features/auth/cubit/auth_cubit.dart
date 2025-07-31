import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/models/admin_model.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo.dart';
import '../../../core/utilis/constants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.adminAuthRepo, required this.sharedPreferences, required this.adminInfoRepo})
      : super(AuthInitial());
  final AdminAuthRepo adminAuthRepo;
  final SharedPreferences sharedPreferences;
  final AdminInfoRepo adminInfoRepo;

  Future<void> signIn({
    required String email,
    required String password,
  }) async
  {
    emit(AuthLoading());
    final result = await adminAuthRepo.SignIn(email: email, password: password);
    result.fold((failure) {
      log(failure.message);
      emit(AuthFailure(error: failure.message));
    }, (response) async {
      await sharedPreferences.setString(accessToken, response.token);
      await getAdminInfo(adminId: response.userId);
      emit(AuthSuccess());
    });
  }

  Future<void> getAdminInfo({required String adminId}) async {
    emit(GetAdminInfoLoading());
    var result = await adminInfoRepo.getAdminInfo(adminId: adminId);
    result.fold((failure) {
      log(failure.message);
      emit(GetAdminInfoFailure(error: failure.message));
    }, (adminModel) {
      saveAdminInfoIntoShared(adminModel: adminModel);
      emit(GetAdminInfoSuccess());
    });
  }

  void saveAdminInfoIntoShared({required AdminModel adminModel}) {
    var data = jsonEncode(adminModel.toJson());
    sharedPreferences.setString(adminInfo, data);
  print('savvvvvvvvvved');
  }

}