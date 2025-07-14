import 'package:dio/dio.dart';

import '../config.dart';
import 'req.dart';

class AppService {
  final Req req = Req();

  // Login
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/auth/login', data);
  }

  // Signup
  Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/auth/register', data);
  }

  // getotp
  Future<Map<String, dynamic>> getotp(Map<String, dynamic> data) async {
    return await req.post(
      '${Configs.baseUrl}api/auth/request-password-reset',
      data,
    );
  }

  // verifyOtp
  Future<Map<String, dynamic>> verifyOtp(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/auth/verify-otp', data);
  }

  // newPassword
  Future<Map<String, dynamic>> newPassword(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/auth/reset-password', data);
  }

  // Update User Profile
  Future<Map<String, dynamic>> updateUserProfile(
    Map<String, dynamic> data,
  ) async {
    return await req.put('${Configs.baseUrl}api/user/profile', data);
  }

  // deleteUser
  Future<Map<String, dynamic>> deleteUser(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/user/self-delete', data);
  }

  // changePassword

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/user/password', data);
  }

  // updateUser
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/updateUser', data);
  }

  // Upload Image
  Future<Map<String, dynamic>> uploadImage(FormData data) async {
    return await req.postMultipart(
      '${Configs.baseUrl}api/upload/upload-mixed',
      data,
    );
  }

  // Get All Categories
  Future<Map<String, dynamic>> getCategoriesbystoretype(
    String storeType,
  ) async {
    return await req.get(
      '${Configs.baseUrl}api/category/store-type/$storeType',
    );
  }

  // Get all banners by store type

  Future<Map<String, dynamic>> getBannersByStoreType(String storeType) async {
    return await req.get('${Configs.baseUrl}api/banners/store-type/$storeType');
  }

  // Get product cars jets yehts
  Future<Map<String, dynamic>> getTransportList(String store) async {
    return await req.get('${Configs.baseUrl}api/transport?type=$store');
  }

  // get properties

  Future<Map<String, dynamic>> getproperties() async {
    return await req.get('${Configs.baseUrl}api/properties');
  }

  // get shopping

  Future<Map<String, dynamic>> getshopping() async {
    return await req.get('${Configs.baseUrl}api/shopping');
  }

  // Order api
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/transportbooking', data);
  }

  // Order api
  Future<Map<String, dynamic>> placeCarBuyOrder(
    Map<String, dynamic> data,
  ) async {
    return await req.post('${Configs.baseUrl}api/transportbooking', data);
  }

  // Get All Properties (Added missing method)
  Future<Map<String, dynamic>> getAllProperties() async {
    return await req.get('${Configs.baseUrl}api/properties/all');
  }

  // Get All Experiences (Added missing method)
  Future<Map<String, dynamic>> getAllExperiences() async {
    return await req.get('${Configs.baseUrl}api/experiences/all');
  }

  Future<Map<String, dynamic>> getExperiences() async {
    return await req.get('${Configs.baseUrl}api/experience');
  }

  Future<Map<String, dynamic>> getExperienceById(String id) async {
    return await req.get('${Configs.baseUrl}api/experience/$id');
  }

  // Existing Service Methods with proper typing

  Future<Map<String, dynamic>> getServicesByCategory(String category) async {
    return await req.get('${Configs.baseUrl}api/services/category/$category');
  }

  Future<Map<String, dynamic>> getServicesByStoreType(String storeType) async {
    return await req.get('${Configs.baseUrl}api/services/store/$storeType');
  }


Future<Map<String, dynamic>> getAllServices() async {
    return await req.get('${Configs.baseUrl}api/service/');
  }

  Future<Map<String, dynamic>> getServiceById(String id) async {
    return await req.get('${Configs.baseUrl}api/service/$id');
  }

  Future<Map<String, dynamic>> getAllBanners() async {
    return await req.get('${Configs.baseUrl}api/banner/all');
  }

  Future<Map<String, dynamic>> getAllCars() async {
    return await req.get('${Configs.baseUrl}api/cars/all');
  }
}
