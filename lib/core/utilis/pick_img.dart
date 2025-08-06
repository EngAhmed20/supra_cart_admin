import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({required ImagePicker picker}) async {
  try{
    final XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
   File? fileImg=File(pickedFile!.path);
   return fileImg;

  }catch (e) {
    return null;
  }


}