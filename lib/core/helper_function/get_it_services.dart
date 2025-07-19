

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secret_data.dart';
import '../utilis/constants.dart';

final getIt = GetIt.instance;

class ServicesLoacator {
  void init() async{
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
    final sharedPrefs = await SharedPreferences.getInstance();

    getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    ///Dio
    getIt.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'apikey': SecretData.supabaseAnonKey},
      ),
    ));
    // API Service


  }
}
