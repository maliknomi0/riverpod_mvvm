import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import 'req.dart';

class AppService {
  final Req req = Req();

  // Login
  Future<dynamic> login(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}auth/login', data);
  }

  // Google Login
  Future<dynamic> googleLogin(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}auth/google-login', data);
  }

  // Signup
  Future<dynamic> signup(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}auth/register', data);
  }

  // getotp
  Future<dynamic> getotp(Map<String, dynamic> data) async {
    return await req.post(
      '${Configs.baseUrl}auth/request-password-reset',
      data,
    );
  }

  // verifyOtp
  Future<dynamic> verifyOtp(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}auth/verify-otp', data);
  }

  // newpassowrd
  Future<dynamic> newPassword(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}auth/reset-password', data);
  }

  // ✅ Update User Profile (Edit Profile API)
  Future<dynamic> updateUserProfile(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}user/profile', data);
  }

  // deleteUser
  Future<dynamic> deleteUser(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}user/self-delete', data);
  }

  //charepassword
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}user/password', data);
  }

  // Upload Image
  Future<dynamic> uploadImage(FormData data) async {
    return await req.postMultipart(
      '${Configs.baseUrl}upload/upload-mixed',
      data,
    );
  }

  //changeorgnization
  Future<dynamic> submitReferral(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}user/organization', data);
  }

  //getcustom
  Future<dynamic> getCustomMeals(int userId) async {
    return await req.get('${Configs.baseUrl}custommeal/user/$userId');
  }

  //getNutritionPlans

  Future<dynamic> getNutritionPlans(int userId) async {
    return await req.get('${Configs.baseUrl}nutritionplan/user/$userId');
  }

  Future<dynamic> getActiveNutritionPlan(int userId) async {
    return await req.get('${Configs.baseUrl}nutritionplan/user/$userId');
  }

  // In app_services.dart
  Future<dynamic> toggleRecipeLog(
    int planId,
    String mealType,
    Map<String, dynamic> recipe,
  ) async {
    return await req.post(
      '${Configs.baseUrl}nutritionplan/nutrition-plan/$planId/meal/$mealType/log',
      {'recipe': recipe},
    );
  }

//add resipewith log
  Future<dynamic> addrecipesWithLog(
    int planId,
    Map<String, dynamic> recipe,
  ) async {
    return await req.post(
      '${Configs.baseUrl}nutritionplan/addandlogrecipe/$planId',
      recipe,
    );
  }

  Future<dynamic> fetchallRecipes(Map<String, dynamic> body) async {
    return await req.post(
      '${Configs.baseUrl}recipes/filterRecipesByMacros',
      body,
    );
  }

  Future<dynamic> searchIngredients(data) async {
    return await req.post('${Configs.baseUrl}ingredients/search', data);
  }

  Future<dynamic> addCustomMeal(data) async {
    return await req.post('${Configs.baseUrl}custommeal/manual', data);
  }

  // Get All getNutritionHistory
  Future<dynamic> getNutritionHistory(userid) async {
    return await req.get('${Configs.baseUrl}nutritionplan/history/$userid');
  }

  // Get All Users
  Future<dynamic> getNutritionPlanById(planid) async {
    return await req.get('${Configs.baseUrl}nutritionplan/plan/$planid');
  }

  Future<dynamic> postCheckIn(data) async {
    return await req.post('${Configs.baseUrl}checkin', data);
  }

  //get all checkins
  Future<dynamic> getCheckInByUserId(int userid) async {
    return await req.get('${Configs.baseUrl}checkin/user/$userid');
  }

  Future<dynamic> updateCheckIn(String id, Map<String, dynamic> payload) async {
    return await req.post('${Configs.baseUrl}checkin/update/$id', payload);
  }

  //
  Future<dynamic> deleteCheckIn(int id) async {
    return await req.post('${Configs.baseUrl}checkin/delete/$id', {});
  }

  // Get Recipes By Page
  Future<dynamic> getPaginatedRecipes({int page = 1, int limit = 10}) async {
    return await req.get(
      '${Configs.baseUrl}api/recipes/page?page=$page&limit=$limit',
    );
  }

  Future<dynamic> getTailoredRecipe(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/adjust-recipe-by-id/1', data);
  }

  // Exercise Section
  // get exercises plan by the userid
  Future<dynamic> getExercisePlan(String userid) async {
    debugPrint("Fetching '${Configs.baseUrl}exerciseplan/$userid'");
    return await req.get('${Configs.baseUrl}exerciseplan/$userid');
  }

  Future<dynamic> getExercisePlanHistory(
      String userid, String exerciseId) async {
    debugPrint(
        "Fetching '${Configs.baseUrl}exerciseplan/history/$userid/logs/$exerciseId'");
    return await req
        .get('${Configs.baseUrl}exerciseplan/history/$userid/logs/$exerciseId');
  }

  Future<dynamic> getAllExercisePlanHistory(String userid) async {
    debugPrint("Fetching '${Configs.baseUrl}exerciseplan/history/$userid'");
    return await req.get('${Configs.baseUrl}exerciseplan/history/$userid');
  }

  Future<dynamic> addExerciseLog(
    Map<String, dynamic> data,
    String userid,
  ) async {
    return await req.post(
      '${Configs.baseUrl}exerciseplan/$userid/exercise-log',
      data,
    );
  }

  Future<dynamic> editExerciseLog(
    Map<String, dynamic> data,
    String userid,
  ) async {
    return await req.put(
      '${Configs.baseUrl}exerciseplan/$userid/exercise-log',
      data,
    );
  }

  Future<dynamic> deleteExerciseLog(
    String userid,
    Map<String, dynamic> payload,
  ) async {
    return await req.deletewithpayload(
      '${Configs.baseUrl}exerciseplan/$userid/exercise-log',
      payload,
    );
  }

  //fitness log

  Future<Map<String, dynamic>> getUserFitnessLog(int? userId) async {
    return await req.get(
      '${Configs.baseUrl}logs/$userId',
    ); // Update path if needed
  }

  Future<dynamic> logUserFitnessData(
    int id,
    Map<String, Object> payload,
  ) async {
    return await req.post('${Configs.baseUrl}logs/$id/consumed', payload);
  }

  Future<dynamic> getAllSessions(String userid) async {
    // debugPrint("Fetching '${Configs.baseUrl}exerciseplan/$userid'");
    return await req.get('${Configs.baseUrl}sessions/user/$userid');
  }

  Future<dynamic> fcmtokken(Map<String, dynamic> payload) async {
    return await req.post(
      '${Configs.baseUrl}auth/update-fcm-token',
      payload,
    );
  }

  /// Fetch users available for chat in the current organization
  Future<dynamic> getChatUsersByOrganization(int organizationId) async {
    return await req.get(
      '${Configs.baseUrl}organization/chat-users/$organizationId',
    );
  }

  Future<dynamic> createOrAccessChat(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}chat/post', data);
  }

  Future<dynamic> fetchChats() async {
    return await req.get('${Configs.baseUrl}chat/get');
  }

  Future<dynamic> sendMessage(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}message/post', data);
  }

  Future<dynamic> fetchMessages(int chatId) async {
    return await req.get('${Configs.baseUrl}message/get/$chatId');
  }

  Future<dynamic> deleteMessage(int messageId) async {
    return await req
        .patch('${Configs.baseUrl}message/get/$messageId', {"isDeleted": true});
  }

  //fetch all notifications
  Future<dynamic> fetchNotifications(String userId) async {
    return await req.get('${Configs.baseUrl}notifications/$userId');
  }

  Future<dynamic> markNotificationAsRead(String notificationId) async {
    return await req.putwithoutdata(
        '${Configs.baseUrl}notifications/$notificationId/markAsRead');
  }

//payment plans
  Future<dynamic> paymentplans() async {
    return await req.get('${Configs.baseUrl}plan/plans');
  }

  //scribe plan

  Future<dynamic> subscribePlan(dynamic data) async {
    return await req.post('${Configs.baseUrl}stripe/subscribeToPlan', data);
  }

  Future<dynamic> getonlinePaymentSheetClientSecret(
    String userId,
    String planId,
  ) async {
    final data = {"userId": userId, "planId": planId};
    final url = '${Configs.baseUrl}stripe/payment-sheet/start';
    return await req.post(url, data);
  }

  Future<dynamic> confirmonlinePaymentSheetSubscription(
    String userId,
    String planId,
    String customerId,
    String paymentMethodId,
  ) async {
    final data = {
      "userId": userId,
      "planId": planId,
      "customerId": customerId,
      "paymentMethodId": paymentMethodId
    };

    return await req.post(
        '${Configs.baseUrl}stripe/payment-sheet/confirm', data);
  }


  Future<dynamic> getphysicalPaymentSheetClientSecret(
    String userId,
    String planId,
  ) async {
    final data = {"userId": userId, "planId": planId};
    final url = '${Configs.baseUrl}stripe/physical-plan-payment-sheet/start';
    return await req.post(url, data);
  }

  Future<dynamic> confirmphysicalPaymentSheetSubscription(
    String userId,
    String planId,
    String customerId,
    String paymentMethodId,
  ) async {
    final data = {
      "userId": userId,
      "planId": planId,
      "customerId": customerId,
      "paymentMethodId": paymentMethodId
    };

    return await req.post(
        '${Configs.baseUrl}stripe/physical-plan-payment/confirm', data);
  }

  Future<dynamic> cancelSubscription(int userId, int planId) async {
    final data = {"userId": userId, "planId": planId};
    return await req.post(
        '${Configs.baseUrl}stripe/app-cancel-subscription/cancel', data);
  }
}
