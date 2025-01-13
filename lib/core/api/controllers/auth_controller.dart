import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbbbites_flutter_app/core/api/services/auth_service.dart';
import 'package:turbbbites_flutter_app/models/auth_model.dart';

class AuthApiController extends GetxController {
  final service = Get.put(AuthApiService());
  static AuthApiController get controller => Get.find<AuthApiController>();
  RxBool get isLoading => service.isLoading;
  RxBool get isError => service.isError;
  RxBool get isSuccess => service.isSuccess;
  RxString get error => service.error;
  RxString get message => service.message;

  Rxn<AuthModel> authModel = Rxn<AuthModel>();

  @override
  void onInit() {
    super.onInit();
    getSharedPreferences();
  }

  Future<bool> validateSession() async {
    if (authModel.value == null) {
      return false;
    }
    final response = await service.validateSession();
    if (response.isSuccess) {
      authModel.value = null;
      return true;
    }
    return false;
  }

  Future<AuthModel?> login(String email, String password) async {
    final response = await service.login(email, password);
    if (response.isSuccess) {
      authModel.value = response.data;
      await setSharedPreferences();
      authModel.refresh();
      return response.data;
    }
    return null;
  }

  Future<AuthModel?> register(
      String fullname, String email, String password) async {
    final response = await service.register(fullname, email, password);
    if (response.isSuccess) {
      authModel.value = response.data;
      await setSharedPreferences();
      authModel.refresh();
      return response.data;
    }
    return null;
  }

  Future<AuthModel?> getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("location");
    if (res != null) {
      var model = AuthModel.fromJson(jsonDecode(res));
      controller.authModel.value = model;
      return model;
    }
    return null;
  }

  Future<bool> setSharedPreferences() async {
    if(authModel.value == null) {
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
        "session",
        jsonEncode({
          'token': authModel.value!.token,
          'role': authModel.value!.role.name,
          'email': authModel.value!.email,
          'fullname': authModel.value!.fullname,
          'status': authModel.value!.status.name,
        }).toString());
  }
}
