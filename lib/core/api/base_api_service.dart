import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/base_api_controller.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/core/api/http_error.dart';

class ApiResponse<T> {
  final T? data;
  final String? error;
  final String? message;
  final bool isSuccess;

  ApiResponse({
    this.data,
    this.error,
    this.message,
    required this.isSuccess,
  });
}

abstract class BaseApiService extends GetxController with BaseApiController {
  late Dio _instance;
  static final String _baseURL = 'http://192.168.141.199:3000';

  static String get baseURL => _baseURL;

  BaseApiService() {
    _instance = createDio();
  }

  Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: _baseURL,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',

      },
    ));

    // Add logging
    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
      error: false,

    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AuthApiController authController = AuthApiController.controller;
          final token = authController.authModel.value?.token;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        // onError: (error, handler) async {
        //   // Handle errors globally
        //   return handler.next(error);
        // },
      ),
    );

    return dio;
  }

  // Generic GET request with query parameters
  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      resetStates();
      setLoading(true);

      final response = await _instance.get(
        endpoint,
        queryParameters: queryParams,
      );


      if (response.statusCode == 200) {
        final data = fromJson != null ? fromJson(response.data) : response.data;
        setSuccess(true);
        return ApiResponse(data: data, isSuccess: true);
      }
      throw HttpError(response.statusCode, response.data['error'],
          response.data['message']);
    } on DioException catch (e) {
      _handleDioError(e);
      return ApiResponse(error: error.value, isSuccess: false);
    } on HttpError catch (e) {
      setError(e.error);
      setMessage(e.message);
      return ApiResponse(
          error: error.value, message: message.value, isSuccess: false);
    } catch (e) {
      setError(e.toString());
      return ApiResponse(error: error.value, isSuccess: false);
    } finally {
      setLoading(false);
    }
  }

  // Generic POST request
  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    T Function(dynamic)? fromJson,
    required Map<String, dynamic> data,
  }) async {
    try {
      resetStates();
      setLoading(true);

      // Log the request data
      final response = await _instance.post(
        endpoint,
        data: data,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData =
            fromJson != null ? fromJson(response.data) : response.data;
        setSuccess(true);
        return ApiResponse(data: responseData, isSuccess: true);
      }

      throw HttpError(response.statusCode, response.data['error'],
          response.data['message']);
    } on HttpError catch (e) {
      print("HttpError");
      print(e);
      setError(e.error);
      setMessage(e.message);
      return ApiResponse(
          error: error.value, message: message.value, isSuccess: false);
    } on DioException catch (e) {
      print("DioException");
      print(e);
      _handleDioError(e);
      return ApiResponse(error: error.value, isSuccess: false);
    } catch (e) {
      print("Error");
      print(e.toString());
      setError(e.toString());
      return ApiResponse(error: error.value, isSuccess: false);
    } finally {
      setLoading(false);
    }
  }

  // Generic PUT request
  Future<ApiResponse<T>> put<T>({
    required String endpoint,
    required dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      resetStates();
      setLoading(true);

      final response = await _instance.put(
        endpoint,
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData =
            fromJson != null ? fromJson(response.data) : response.data;
        setSuccess(true);
        return ApiResponse(data: responseData, isSuccess: true);
      }

      throw HttpError(response.statusCode, response.data['error'],
          response.data['message']);
    } on DioException catch (e) {
      _handleDioError(e);
      return ApiResponse(error: error.value, isSuccess: false);
    } on HttpError catch (e) {
      setError(e.error);
      setMessage(e.message);
      return ApiResponse(
          error: error.value, message: message.value, isSuccess: false);
    } catch (e) {
      setError(e.toString());
      return ApiResponse(error: error.value, isSuccess: false);
    } finally {
      setLoading(false);
    }
  }

  // Generic DELETE request
  Future<ApiResponse<bool>> delete({
    required String endpoint,
  }) async {
    try {
      resetStates();
      setLoading(true);

      final response = await _instance.delete(endpoint);

      if (response.statusCode == 200 || response.statusCode == 204) {
        setSuccess(true);
        return ApiResponse(data: true, isSuccess: true);
      }

      throw HttpError(response.statusCode, response.data['error'],
          response.data['message']);
    } on DioException catch (e) {
      _handleDioError(e);
      return ApiResponse(error: error.value, isSuccess: false);
    } on HttpError catch (e) {
      setError(e.error);
      setMessage(e.message);
      return ApiResponse(
          error: error.value, message: message.value, isSuccess: false);
    } catch (e) {
      setError(e.toString());
      return ApiResponse(error: error.value, isSuccess: false);
    } finally {
      setLoading(false);
    }
  }

  // Error handler for Dio exceptions
  void _handleDioError(DioException error) {
    print(error);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        setError('Connection timeout');
        setMessage('Please check your internet connection');
      case DioExceptionType.receiveTimeout:
        setError('Receive timeout');
        setMessage('Please check your internet connection');
      case DioExceptionType.badResponse:
        if(error.response?.statusCode == 401) {
          setError('Unauthorized');
          setMessage('Please login to continue');
        } else {
          setError('Bad response: ${error.response?.statusCode}');
          setMessage('Please try again later');
        }
      case DioExceptionType.cancel:
        setError('Request cancelled');
        setMessage('Please try again later');
      default:
        setError('Network error occurred');
        setMessage('Please try again later');
    }
  }
}
