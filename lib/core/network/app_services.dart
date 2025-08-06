import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpordmvvm/core/config/app_config.dart';
import 'package:riverpordmvvm/core/network/req.dart';


class AppService {
  final Req req = Req();

  // Login
  Future<dynamic> login(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}auth/login', data);
  }

  // Google Login
  Future<dynamic> googleLogin(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}auth/google-login', data);
  }

  // Signup
  Future<dynamic> signup(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}auth/register', data);
  }

  // getotp
  Future<dynamic> getotp(Map<String, dynamic> data) async {
    return await req.post(
      '${configs.baseUrl}auth/request-password-reset',
      data,
    );
  }

  // verifyOtp
  Future<dynamic> verifyOtp(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}auth/verify-otp', data);
  }

  // newpassowrd
  Future<dynamic> newPassword(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}auth/reset-password', data);
  }

  // ✅ Update User Profile (Edit Profile API)
  Future<dynamic> updateUserProfile(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}user/profile', data);
  }

  // deleteUser
  Future<dynamic> deleteUser(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}user/self-delete', data);
  }

  //charepassword
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}user/password', data);
  }

  // Upload Image
  Future<dynamic> uploadImage(FormData data) async {
    return await req.postMultipart(
      '${configs.baseUrl}upload/upload-mixed',
      data,
    );
  }

  //changeorgnization
  Future<dynamic> submitReferral(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}user/organization', data);
  }

  //getcustom
  Future<dynamic> getCustomMeals(int userId) async {
    return await req.get('${configs.baseUrl}custommeal/user/$userId');
  }

  //getNutritionPlans

  Future<dynamic> getNutritionPlans(int userId) async {
    return await req.get('${configs.baseUrl}nutritionplan/user/$userId');
  }

  Future<dynamic> getActiveNutritionPlan(int userId) async {
    return await req.get('${configs.baseUrl}nutritionplan/user/$userId');
  }

  // In app_services.dart
  Future<dynamic> toggleRecipeLog(
    int planId,
    String mealType,
    Map<String, dynamic> recipe,
  ) async {
    return await req.post(
      '${configs.baseUrl}nutritionplan/nutrition-plan/$planId/meal/$mealType/log',
      {'recipe': recipe},
    );
  }

//add resipewith log
  Future<dynamic> addrecipesWithLog(
    int planId,
    Map<String, dynamic> recipe,
  ) async {
    return await req.post(
      '${configs.baseUrl}nutritionplan/addandlogrecipe/$planId',
      recipe,
    );
  }

  Future<dynamic> fetchallRecipes(Map<String, dynamic> body) async {
    return await req.post(
      '${configs.baseUrl}recipes/filterRecipesByMacros',
      body,
    );
  }

  Future<dynamic> searchIngredients(data) async {
    return await req.post('${configs.baseUrl}ingredients/search', data);
  }

  Future<dynamic> addCustomMeal(data) async {
    return await req.post('${configs.baseUrl}custommeal/manual', data);
  }

  // Get All getNutritionHistory
  Future<dynamic> getNutritionHistory(userid) async {
    return await req.get('${configs.baseUrl}nutritionplan/history/$userid');
  }

  // Get All Users
  Future<dynamic> getNutritionPlanById(planid) async {
    return await req.get('${configs.baseUrl}nutritionplan/plan/$planid');
  }

  Future<dynamic> postCheckIn(data) async {
    return await req.post('${configs.baseUrl}checkin', data);
  }

  //get all checkins
  Future<dynamic> getCheckInByUserId(int userid) async {
    return await req.get('${configs.baseUrl}checkin/user/$userid');
  }

  Future<dynamic> updateCheckIn(String id, Map<String, dynamic> payload) async {
    return await req.post('${configs.baseUrl}checkin/update/$id', payload);
  }

  //
  Future<dynamic> deleteCheckIn(int id) async {
    return await req.post('${configs.baseUrl}checkin/delete/$id', {});
  }

  // Get Recipes By Page
  Future<dynamic> getPaginatedRecipes({int page = 1, int limit = 10}) async {
    return await req.get(
      '${configs.baseUrl}api/recipes/page?page=$page&limit=$limit',
    );
  }

  Future<dynamic> getTailoredRecipe(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}api/adjust-recipe-by-id/1', data);
  }

  // Exercise Section
  // get exercises plan by the userid
  Future<dynamic> getExercisePlan(String userid) async {
    debugPrint("Fetching '${configs.baseUrl}exerciseplan/$userid'");
    return await req.get('${configs.baseUrl}exerciseplan/$userid');
  }

  Future<dynamic> getExercisePlanHistory(
      String userid, String exerciseId) async {
    debugPrint(
        "Fetching '${configs.baseUrl}exerciseplan/history/$userid/logs/$exerciseId'");
    return await req
        .get('${configs.baseUrl}exerciseplan/history/$userid/logs/$exerciseId');
  }

  Future<dynamic> getAllExercisePlanHistory(String userid) async {
    debugPrint("Fetching '${configs.baseUrl}exerciseplan/history/$userid'");
    return await req.get('${configs.baseUrl}exerciseplan/history/$userid');
  }

  Future<dynamic> addExerciseLog(
    Map<String, dynamic> data,
    String userid,
  ) async {
    return await req.post(
      '${configs.baseUrl}exerciseplan/$userid/exercise-log',
      data,
    );
  }

  Future<dynamic> editExerciseLog(
    Map<String, dynamic> data,
    String userid,
  ) async {
    return await req.put(
      '${configs.baseUrl}exerciseplan/$userid/exercise-log',
      data,
    );
  }

  Future<dynamic> deleteExerciseLog(
    String userid,
    Map<String, dynamic> payload,
  ) async {
    return await req.deletewithpayload(
      '${configs.baseUrl}exerciseplan/$userid/exercise-log',
      payload,
    );
  }

  //fitness log

  Future<Map<String, dynamic>> getUserFitnessLog(int? userId) async {
    return await req.get(
      '${configs.baseUrl}logs/$userId',
    ); // Update path if needed
  }

  Future<dynamic> logUserFitnessData(
    int id,
    Map<String, Object> payload,
  ) async {
    return await req.post('${configs.baseUrl}logs/$id/consumed', payload);
  }

  Future<dynamic> getAllSessions(String userid) async {
    // debugPrint("Fetching '${configs.baseUrl}exerciseplan/$userid'");
    return await req.get('${configs.baseUrl}sessions/user/$userid');
  }

  Future<dynamic> fcmtokken(Map<String, dynamic> payload) async {
    return await req.post(
      '${configs.baseUrl}auth/update-fcm-token',
      payload,
    );
  }

  /// Fetch users available for chat in the current organization
  Future<dynamic> getChatUsersByOrganization(int organizationId) async {
    return await req.get(
      '${configs.baseUrl}organization/chat-users/$organizationId',
    );
  }

  Future<dynamic> createOrAccessChat(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}chat/post', data);
  }

  Future<dynamic> fetchChats() async {
    return await req.get('${configs.baseUrl}chat/get');
  }

  Future<dynamic> sendMessage(Map<String, dynamic> data) async {
    return await req.post('${configs.baseUrl}message/post', data);
  }

  Future<dynamic> fetchMessages(int chatId) async {
    return await req.get('${configs.baseUrl}message/get/$chatId');
  }

  Future<dynamic> deleteMessage(int messageId) async {
    return await req
        .patch('${configs.baseUrl}message/get/$messageId', {"isDeleted": true});
  }

  //fetch all notifications
  Future<dynamic> fetchNotifications(String userId) async {
    return await req.get('${configs.baseUrl}notifications/$userId');
  }

  Future<dynamic> markNotificationAsRead(String notificationId) async {
    return await req.putwithoutdata(
        '${configs.baseUrl}notifications/$notificationId/markAsRead');
  }

//payment plans
  Future<dynamic> paymentplans() async {
    return await req.get('${configs.baseUrl}plan/plans');
  }

  //scribe plan

  Future<dynamic> subscribePlan(dynamic data) async {
    return await req.post('${configs.baseUrl}stripe/subscribeToPlan', data);
  }

  Future<dynamic> getonlinePaymentSheetClientSecret(
    String userId,
    String planId,
  ) async {
    final data = {"userId": userId, "planId": planId};
    final url = '${configs.baseUrl}stripe/payment-sheet/start';
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
        '${configs.baseUrl}stripe/payment-sheet/confirm', data);
  }


  Future<dynamic> getphysicalPaymentSheetClientSecret(
    String userId,
    String planId,
  ) async {
    final data = {"userId": userId, "planId": planId};
    final url = '${configs.baseUrl}stripe/physical-plan-payment-sheet/start';
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
        '${configs.baseUrl}stripe/physical-plan-payment/confirm', data);
  }

  Future<dynamic> cancelSubscription(int userId, int planId) async {
    final data = {"userId": userId, "planId": planId};
    return await req.post(
        '${configs.baseUrl}stripe/app-cancel-subscription/cancel', data);
  }
}
