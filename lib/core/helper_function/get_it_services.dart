import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart_admin/core/helper_function/api_services.dart';
import 'package:supra_cart_admin/core/helper_function/base_api_services.dart';
import 'package:supra_cart_admin/core/helper_function/storage_service.dart';
import 'package:supra_cart_admin/core/helper_function/supabase_storage.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo_impl.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo_impl.dart';
import 'package:supra_cart_admin/features/products/data/repo/product_repo.dart';
import 'package:supra_cart_admin/features/products/data/repo/product_repo_impl.dart';
import '../secret_data.dart';
import '../utilis/constants.dart';

final getIt = GetIt.instance;

class ServicesLoacator {
  void init() async{
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
    final sharedPrefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
    getIt.registerLazySingleton<BaseApiServices>(()=>ApiServices(dio: getIt.get<Dio>()));
    getIt.registerLazySingleton<BaseApiServices>(()=>ApiServices(dio: getIt.get<Dio>(instanceName: authDio)),instanceName: authApi);
    getIt.registerLazySingleton<StorageService>(()=>SupabaseStorage(client: getIt.get<SupabaseClient>()));

    ///Dio
    getIt.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'apikey': SecretData.supabaseAnonKey},
      ),
    ),
    );
    /// create acc dio
    getIt.registerLazySingleton<Dio>(()=>Dio(BaseOptions(
      baseUrl: authBaseUrl,
      headers: {'apikey': SecretData.supabaseAnonKey},
    ),
    ),instanceName:authDio);
    // API Service
    getIt.registerLazySingleton<AdminAuthRepo>(()=>AdminAuthRepoImpl(baseApiServices:getIt.get<BaseApiServices>(instanceName: authApi)));

    getIt.registerLazySingleton<AdminInfoRepo>(()=>AdminInfoRepoImp(apiServices: getIt.get<BaseApiServices>()));
    getIt.registerLazySingleton<ProductRepo>(()=>ProductRepoImpl(apiServices: getIt.get<BaseApiServices>()));

  }
}
