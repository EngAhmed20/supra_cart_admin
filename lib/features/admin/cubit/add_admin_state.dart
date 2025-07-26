part of 'add_admin_cubit.dart';

@immutable
abstract class AddAdminState {}

class AddAdminInitial extends AddAdminState {}
class AddAdminLoading extends AddAdminState {}
class AddAdminSuccess extends AddAdminState {}
class AddAdminFailure extends AddAdminState {
  final String error;
  AddAdminFailure({required this.error});
}
