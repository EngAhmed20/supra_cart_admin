import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart_admin/core/repo/admin_info_repo.dart';
import 'package:supra_cart_admin/features/admin/data/repo/admin_auth_repo.dart';
import 'package:supra_cart_admin/features/auth/cubit/auth_cubit.dart';
import 'package:supra_cart_admin/features/splash/view/splash_view.dart';

import 'bloc_observer.dart';
import 'core/helper_function/get_it_services.dart';
import 'core/helper_function/on_generate_route.dart';
import 'core/secret_data.dart';
import 'core/style/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SecretData.supabaseUrl,
    anonKey: SecretData.supabaseAnonKey,
  );
  Bloc.observer = blocObserver();
  ServicesLoacator().init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_,child){
        return MultiBlocProvider(providers: [
          BlocProvider(create: (context)=>AuthCubit(adminAuthRepo: getIt.get<AdminAuthRepo>(), sharedPreferences: getIt.get<SharedPreferences>(), adminInfoRepo: getIt.get<AdminInfoRepo>()))
        ], child:MaterialApp(
          title: 'Supra Cart Dashboard',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          onGenerateRoute: onGenerateRoute,
          initialRoute: SplashView.routeName,
          debugShowCheckedModeBanner: false,
        ));
      },
    );
  }
}


