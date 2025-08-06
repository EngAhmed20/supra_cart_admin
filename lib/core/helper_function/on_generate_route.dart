import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/helper_function/get_it_services.dart';
import 'package:supra_cart_admin/core/helper_function/storage_service.dart';
import 'package:supra_cart_admin/features/admin/view/add_admin_view.dart';
import 'package:supra_cart_admin/features/auth/view/login_view.dart';
import 'package:supra_cart_admin/features/home/view/home_view.dart';
import 'package:supra_cart_admin/features/orders/views/orders_view.dart';
import 'package:supra_cart_admin/features/products/cubit/product_cubit.dart';
import 'package:supra_cart_admin/features/products/data/repo/product_repo.dart';
import 'package:supra_cart_admin/features/products/view/comments_view.dart';
import 'package:supra_cart_admin/features/splash/view/splash_view.dart';
import '../../features/products/view/add_product_view.dart';
import '../../features/products/view/edit_product_view.dart';
import '../../features/products/view/product_view.dart';
import '../models/product_model.dart';
Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case ProductView.routeName:
      return MaterialPageRoute(builder: (_) => BlocProvider(create: (context)=>ProductCubit(getIt.get<ProductRepo>(),
          getIt.get<SharedPreferences>(),getIt.get<StorageService>()),
      child: const ProductView(),
      ));
    case EditProductView.routeName:
      final product = settings.arguments as ProductModel;
      return MaterialPageRoute(builder: (_) =>  EditProductView(
        selectedProduct: product,
      ));
    case CommentsView.routeName:
      return MaterialPageRoute(builder: (_) => const CommentsView());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (_)  => BlocProvider(create: (context)=>ProductCubit(getIt.get<ProductRepo>(),
          getIt.get<SharedPreferences>(),getIt.get<StorageService>()),
        child: const AddProductView(),
      ));
    case AddAdminView.routeName:
      return MaterialPageRoute(builder: (_)=>const AddAdminView());
    case OrdersView.routeName:
      return MaterialPageRoute(builder: (_) => const OrdersView());
      default:
      return MaterialPageRoute(builder: (_) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ));
  }
}