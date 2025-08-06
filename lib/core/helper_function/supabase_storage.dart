import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart_admin/core/helper_function/storage_service.dart';
import 'package:supra_cart_admin/core/utilis/constants.dart';
import 'package:uuid/uuid.dart';

class SupabaseStorage implements StorageService{
  final SupabaseClient client;

  SupabaseStorage({required this.client});
  @override
  Future<String> uploadFile(File image) async{
    final uuid = Uuid();
    final uniqueName = uuid.v4(); // توليد اسم فريد
    final originalName = p.basename(image.path);
    final fileName = "$uniqueName-$originalName";
    final bucket=client.storage.from(bucketName);
    await bucket.upload(fileName,image);
    final publicUrl = bucket.getPublicUrl(fileName);
    print(publicUrl);
    return publicUrl;
  }
}