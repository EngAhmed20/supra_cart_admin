part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class GetProductLoading extends ProductState {}
class GetProductSuccess extends ProductState {}
class GetProductFailure extends ProductState {
  final String message;
  GetProductFailure({required this.message});
}
class AuthSignOutSuccess extends ProductState{}
class AccessTokenExpired extends ProductState{}
class AddProductLoading extends ProductState {}
class AddProductSuccess extends ProductState {}
class AddProductFailure extends ProductState {
  final String message;
  AddProductFailure({required this.message});
}

