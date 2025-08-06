import 'dart:io';

abstract class StorageService{
  Future<String>uploadFile(File image);
}