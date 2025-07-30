import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/admin_model.dart';
import '../../../core/utilis/constants.dart';
part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.sharedPreferences) : super(HomeInitial()){
    init();
  }
  init()async{
    await getAdminInfoFromShared();
    emit(HomeInitial());

  }
  final SharedPreferences sharedPreferences;
  AdminModel? adminModel;
  Future<void> getAdminInfoFromShared() async {
    final adminData = await sharedPreferences.getString(adminInfo);
    if (adminData != null) {
      final adminMap = jsonDecode(adminData);
      adminModel = AdminModel.fromJson(adminMap);

    }
  }
}
