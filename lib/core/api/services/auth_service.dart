import 'package:turbbbites_flutter_app/core/api/base_api_service.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_controller.dart';
import 'package:turbbbites_flutter_app/models/auth_model.dart';

class AuthApiService extends BaseApiService with BaseApiController {

  //GET
  Future<ApiResponse<AuthModel>> validateSession() async {
    return await get<AuthModel>(
      endpoint: '/api/auth/validate',
      fromJson: (json) => AuthModel.fromJson(json),
    );
  }

  //POST
  Future<ApiResponse<AuthModel>> login(String email, String password) async {
    return await post<AuthModel>(
      endpoint: '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (json) => AuthModel.fromJson(json),
    );
  }

  Future<ApiResponse<AuthModel>> register(
      String fullname, String email, String password) async {
    return await post<AuthModel>(
      endpoint: '/api/auth/register',
      data: {
        'fullname': fullname,
        'email': email,
        'password': password,
      },
      fromJson: (json) => AuthModel.fromJson(json),
    );
  }
}
