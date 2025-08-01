part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
class GetAdminInfoLoading extends AuthState {}
class GetAdminInfoSuccess extends AuthState {

}
class GetAdminInfoFailure extends AuthState {
  final String error;

  GetAdminInfoFailure({required this.error});
}
