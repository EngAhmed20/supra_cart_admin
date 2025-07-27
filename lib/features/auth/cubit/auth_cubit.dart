import 'package:bloc/bloc.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.adminAuthRepo}) : super(AuthInitial());
  final AdminAuthRepo adminAuthRepo;
  Future<void>signIn ({
    required String email,
    required String password,
})async
  {
    emit(AuthLoading());
    final result=await adminAuthRepo.SignIn(email: email, password: password);
    result.fold((failure)=>emit(AuthFailure(error: failure.message)),(successResponse){
      emit(AuthSuccess());
    });

  }
}
