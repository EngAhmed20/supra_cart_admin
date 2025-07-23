import 'package:flutter/material.dart';
import 'package:supra_cart_admin/features/admin/view/add_admin_view.dart';
import 'package:supra_cart_admin/features/auth/view/login_view.dart';
import 'package:supra_cart_admin/features/home/view/home_view.dart';
import 'package:supra_cart_admin/features/orders/views/orders_view.dart';
import 'package:supra_cart_admin/features/products/view/comments_view.dart';
import 'package:supra_cart_admin/features/splash/view/splash_view.dart';
import '../../features/products/view/add_product_view.dart';
import '../../features/products/view/edit_product_view.dart';
import '../../features/products/view/product_view.dart';
Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case ProductView.routeName:
      return MaterialPageRoute(builder: (_) => const ProductView());
    case EditProductView.routeName:
      return MaterialPageRoute(builder: (_) => const EditProductView());
    case CommentsView.routeName:
      return MaterialPageRoute(builder: (_) => const CommentsView());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductView());
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