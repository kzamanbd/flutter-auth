import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseURL = "http://192.168.2.139:8000/api";

class Api {
  final Dio _dio = Dio();

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Api() {
    _dio.options.baseUrl = baseURL;
    _dio.options.headers = headers;
    // Add interceptor
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
  }

  Dio get request => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({required this.success, this.data, this.message});

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
        success: data['success'], data: data['data'], message: data['message']);
  }
}
