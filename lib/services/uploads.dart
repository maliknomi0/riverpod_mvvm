import 'dart:io';

import 'package:dio/dio.dart';

import 'app_services.dart';

class ImageUploadService {
  final AppService _appService;

  static final ImageUploadService _instance = ImageUploadService._internal();
  factory ImageUploadService() => _instance;
  ImageUploadService._internal() : _appService = AppService();

  Future<String?> uploadImage(
    File file, {
    String? customFileName,
    required String description,
  }) async {
    try {
      String fileName =
          customFileName ??
          '${DateTime.now().millisecondsSinceEpoch}_${file.path.split("/").last}';

      // Create FormData with the structure shown in the image
      FormData formData = FormData.fromMap({
        'file1': await MultipartFile.fromFile(file.path, filename: fileName),
        'desc1': description, // Add the description field
      });

      var response = await _appService.uploadImage(formData);

      // Check if the response indicates success
      if (response['message'] == 'Files uploaded successfully') {
        List<dynamic> files = response['files'];
        if (files.isNotEmpty) {
          String? fileUrl = files[0]['storedAt'] as String?;
          if (fileUrl != null) {
            return fileUrl; // Return the storedAt path
          }
        }
        print('Image upload failed: No file URL found in response');
        return null;
      } else {
        print('Image upload failed: ${response['message']}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
