import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supra_cart_admin/core/models/product_model.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import '../data/repo/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo, this.sharedPreferences) : super(ProductInitial()) {
    init();
  }
  late String? token;
  final ProductRepo productRepo;
  final SharedPreferences sharedPreferences;
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

}
