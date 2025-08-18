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
  final TextEditingController searchController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final StorageService supabaseStorage;
  List <ProductModel> productList = [];

  init()async{
    token= await sharedPreferences.getString(accessToken);
    await getAllProducts();

  }
  Future<void>getAllProducts()async{
    productList.clear();
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
  /// Add product
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
        },
            (success) {
          productList.add(product);
          emit(AddProductSuccess());
        },
      );

        });

  }
 /// update product
 Future<void>updateProduct({required ProductModel product, File?img})async{
    emit(UpdateProductLoading());
    if(img!=null){
      final storage=await supabaseStorage.replaceFile(oldFileUrl: product.imageUrl, newImage: img);
      storage.fold(
        (failure) => emit(UpdateProductFailure(message: failure.message)),
        (imgUrl) {
          product = product.copyWith(imageUrl: imgUrl);
        },
      );
      if (state is UpdateProductFailure) return;

    }
    final result=await productRepo.updateProduct(product: product, token: token!);
    result.fold(
      (failure) {
        if (failure.message.toLowerCase().contains('jwt expired')) {
          emit(AccessTokenExpired());
          return;
        }
        emit(UpdateProductFailure(message: failure.message));
      },
      (success) {

        emit(UpdateProductSuccess());
      },
    );

 }
 /// remove product
  Future<void>removeProduct({required String productId,required String productImgUrl})async{
   emit(DeleteProductLoading());
   final response=await productRepo.deleteProduct(productId: productId, token: token!);
   response.fold(
       (failure){
         if(failure.message.toLowerCase().contains('jwt expired')){
            emit(AccessTokenExpired());
            return;
         }
          emit(DeleteProductFailure(message: failure.message));

       },(success)async{
         final storage=await supabaseStorage.deleteFile(productImgUrl);
          storage.fold(
            (failure) => emit(DeleteProductFailure(message: failure.message)),
            (success) {
              productList.removeWhere((product) => product.id == productId);
              emit(DeleteProductSuccess());
            },
          );

   }
   );

  }

// search
  void searchButton(context,{required GlobalKey<FormState> searchForm}) {

    if (searchForm.currentState!.validate()) {
      search( searchController.text);
      autovalidateMode = AutovalidateMode.disabled;

    } else {
      autovalidateMode = AutovalidateMode.always;
      emit(AutoValidateState());

    }

  }
  List<ProductModel> searchResults = [];
  search(String query){
    searchResults.clear();
    emit(GetProductLoading());
    for(var product in productList){
      if(product.name.toLowerCase().contains(query.toLowerCase())){
        searchResults.add(product);
      }
      if (searchResults.isEmpty) {
        emit(GetProductFailure(message: 'No products found'));
      } else {
        emit(SearchProductSuccess(searchResults: searchResults));
      }
    }


  }
  void clearSearch() {
    searchResults.clear();
    emit(ClearSearchState());
  }

}
