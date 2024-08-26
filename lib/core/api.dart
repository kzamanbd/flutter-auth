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
  // Handle Dio errors
  ApiResponse handleDioError(DioException error) {
    String errorMessage;

    switch (error.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = "Connection timed out. Please try again.";
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request was cancelled.";
        break;
      case DioExceptionType.unknown:
        errorMessage = "Unexpected error occurred: ${error.message}";
        break;
      default:
        // The server responded with a status code different from 2xx
        if (error.response != null) {
          switch (error.response?.statusCode) {
            case 400:
              errorMessage = "Bad request. Please check your input.";
              break;
            case 401:
              errorMessage = "Unauthorized. Please check your credentials.";
              break;
            case 403:
              errorMessage =
                  "Forbidden. You don't have permission to access this resource.";
              break;
            case 404:
              errorMessage = "Resource not found.";
              break;
            case 500:
              errorMessage = "Internal server error. Please try again later.";
              break;
            default:
              errorMessage =
                  "Received invalid status code: ${error.response?.statusCode}";
          }
        } else {
          errorMessage = "Received invalid response.";
        }
        break;
    }

    return ApiResponse(success: false, message: errorMessage);
  }
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
