import 'package:supra_cart_admin/core/models/product_model.dart';
import 'package:supra_cart_admin/core/models/purchase_model.dart';
import 'package:supra_cart_admin/core/models/user_model.dart';

import 'delivery_info_model.dart';

class PurchaseWithRelations {
  final PurchaseModel purchase;
  final ProductModel product;
  final UserModel userModel;
  final List<DeliveryInfoModel>deliveryInfoModel;

  PurchaseWithRelations( {
    required this.purchase,
    required this.product,
    required this.userModel,
    required this.deliveryInfoModel,
  });

  factory PurchaseWithRelations.fromJson(Map<String, dynamic> json) {
    return PurchaseWithRelations(
      purchase: PurchaseModel.fromJson(json),
      product: ProductModel.fromJson(json['products_table'] ?? {}),
      userModel:UserModel.fromJson(json['users']),
      deliveryInfoModel: (json['users']?['delivery_info'] as List<dynamic>? ??[])
      .map((e)=>DeliveryInfoModel.fromJson(e)).toList(),

    );
  }
}
