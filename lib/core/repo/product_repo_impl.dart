import 'package:dartz/dartz.dart';
import 'package:supra_cart_admin/core/repo/product_repo.dart';

import '../helper_function/base_api_services.dart';
import '../helper_function/failure.dart';
import '../models/comments_model.dart';
import '../models/product_model.dart';
import '../models/product_rate_model.dart';
import '../models/purchase_model.dart';
import '../utilis/constants.dart';


class HomeProductRepoImpl implements HomeProductRepo {
  BaseApiServices apiServices;

  HomeProductRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, List<ProductModel>>> getHomeProducts() async {
    final response = await apiServices.getData(path: homeProductsUrl);
    return response.fold((failure) => Left(Failure(message: failure.message)), (
        successResponse) {
      final data = successResponse as List;
      final products = data.map((e) =>
          ProductModel.fromJson(e as Map<String, dynamic>)).toList();
      return Right(products);
    });
  }

  @override
  Future<Either<Failure, List<ProductRateModel>>> getProductRate(
      {required String productId}) async {
    final response = await apiServices.getData(
        path: productRateUrl + productId);
    return response.fold((failure) => Left(Failure(message: failure.message)), (
        successResponse) {
      final data = successResponse as List;
      print(data);
      final products = data.map((e) =>
          ProductRateModel.fromJson(e as Map<String, dynamic>)).toList();
      return Right(products);
    });
  }

  @override
  Future<Either<Failure, void>> addOrUpdateUserRate(
      {required String productId, required int rate, required String userId, required bool
      isUpdate}) async {
    if (isUpdate) {
      final response = await apiServices.patchData(
          path: 'rates_table?select=*&for_user=eq.$userId&for_product=eq.$productId',
          data: {
            "rate": rate,
          });
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } else {
      final response = await apiServices.postData(
          path: productRateAddUrl, data: {
        "for_user": userId,
        "for_product": productId,
        "rate": rate,
      });
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    }
  }

  @override
  Future<Either<Failure, void>> addComment(
      {required String productId, required String comment, required String userId, required String userName}) async {
    try {
      final response = await apiServices.postData(
          path: postProductCommentsUrl, data: {
        "user_name": userName,
        "for_user": userId,
        "for_product": productId,
        "comments": comment
      });
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(Failure(message: 'Failed to add comment: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Failure, List<CommentModel>>> getProductComments(
      {required String productId}) async* {
    await for (var data in apiServices.getStreamData(path: 'comments_table',
        productId: productId,
        orderBy: 'created_at',
        descending: true)) {
      yield data.fold((failure) => Left(failure), (data) {
        final commentsData = data as List;
        final comments = commentsData.map((e) =>
            CommentModel.fromJson(e as Map<String, dynamic>)).toList();
        return Right(comments);
      });
    }
  }

  @override
  Future<Either<Failure, void>> addProductToFav(
      {required String productId, required String userId, required bool isFav}) async {
    try {
      final response = await apiServices.postData(path: favTable, data: {
        "for_user": userId,
        "for_product": productId,
        "is_favorite": isFav
      });
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(Failure(
          message: 'Failed to add product to favorites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeProductFromFav(
      {required String productId, required String userId}) async {
    try {
      final response = await apiServices.deleteData(
          path: '$favTable?for_user=eq.$userId&for_product=eq.$productId');
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(Failure(
          message: 'Failed to remove product from favorites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> purchaseProduct(
      {required PurchaseModel purchaseModel}) async {
    try {
      final response = await apiServices.postData(
          path: purchaseTable, data: purchaseModel.toJson());
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(
          Failure(message: 'Failed to purchase product: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelPurchase(
      {required String purchaseId}) async {
    try {
      final response = await apiServices.deleteData(
          path: '$purchaseTable?id=eq.$purchaseId');
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(
          Failure(message: 'Failed to cancel purchase: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> confirmReceipt(
      {required String purchaseId}) async {
    try {
      final response = await apiServices.patchData(
          path: '$purchaseTable?id=eq.$purchaseId', data: {
        "order_status": 'Confirm Receipt'
      });
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(
          Failure(message: 'Failed to confirm receipt: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> archivePurchase(
      {required String purchaseId}) async {
    try {
      final response = await apiServices.patchData(
          path: '$purchaseTable?id=eq.$purchaseId',
          data: {
            "order_status": 'Archived'
          });
      return response.fold((failure) =>
          Left(Failure(message: failure.message)), (successResponse) {
        return Right(null);
      });
    } catch (e) {
      return Left(
          Failure(message: 'Failed to confirm receipt: ${e.toString()}'));
    }
  }
}



