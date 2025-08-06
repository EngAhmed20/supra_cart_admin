import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/helper_function/storage_service.dart';
import 'package:supra_cart_admin/core/models/product_model.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import '../data/repo/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo, this.sharedPreferences, this.supabaseStorage,) : super(ProductInitial()) {
    init();
  }
  late String? token;
  final ProductRepo productRepo;
  final SharedPreferences sharedPreferences;
  final StorageService supabaseStorage;
  List <ProductModel> productList = [];

  init()async{
    token= await sharedPreferences.getString(accessToken);
    await getAllProducts();

  }
  Future<void>getAllProducts()async{

    emit(GetProductLoading());
    final result=await productRepo.getAllProducts(token);
    result.fold(
      (failure) => emit(GetProductFailure(message: failure.message)),
      (products){
        for(var product in products){
          productList.add(product);
        }
        emit(GetProductSuccess());

      });

  }
  Future<void> addProduct(ProductModel product,File img) async {
    emit(AddProductLoading());
    final storage=await  supabaseStorage.uploadFile(img);
    storage.fold((failure)=>emit(AddProductFailure(message: failure.message)),
        (imgUrl)async{
      product.imageUrl= imgUrl;
      final result = await productRepo.addProduct(product: product, token: token!);
      result.fold(
            (failure){
          if (failure.message.toLowerCase().contains('jwt expired')) {
            emit(AccessTokenExpired());
            return;
          }
          emit(AddProductFailure(message: failure.message));
          print(failure.message);
        },
            (success) {
          productList.add(product);
          emit(AddProductSuccess());
        },
      );

        });

  }


}
