import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart_admin/core/helper_function/storage_service.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import 'package:uuid/uuid.dart';

import 'failure.dart';

class SupabaseStorage implements StorageService{
  final SupabaseClient client;

  SupabaseStorage({required this.client});
  @override
  Future<Either<Failure,String>>uploadFile (File image)
  async{
    try{
      final uuid = Uuid();
      final uniqueName = uuid.v4(); // توليد اسم فريد
      final originalName = p.basename(image.path);
      final fileName = "$uniqueName-$originalName";
      final bucket=client.storage.from(bucketName);
      await bucket.upload(fileName,image);
      final publicUrl = bucket.getPublicUrl(fileName);
      print(publicUrl);
      return Right(publicUrl);

    }catch(e){
      return Left(Failure(message: "Failed to upload file: ${e.toString()}"));
    }

  }

  @override
  Future<Either<Failure, String>> replaceFile({required String oldFileUrl,
     required File newImage,})async {
    try{
      final bucket=client.storage.from('images');
      final oldFileName=oldFileUrl.split('/').last;
      print(oldFileName);
       await bucket.remove(['products/$oldFileName']);

      final uploadNewImg= await uploadFile(newImage);
      return uploadNewImg.fold(
        (failure) => Left(Failure(message: failure.message)),
        (newFileUrl) => Right(newFileUrl),
      );

    }catch(e){
      print("Error replacing file: ${e.toString()}");
      return Left(Failure(message: "Failed to replace file: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFile(String fileUrl) async{
    try{
      final bucket=client.storage.from('images');
      final fileName=fileUrl.split('/').last;
      await bucket.remove(['products/$fileName']);
      return Right("File deleted successfully");

    }catch(e){
      return Left(Failure(message: "Failed to delete file: ${e.toString()}"));
    }

  }
}