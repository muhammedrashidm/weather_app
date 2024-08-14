import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_weather/utils/data/exception.dart';
import 'package:my_weather/utils/data/logger.dart';
import 'package:my_weather/utils/data/typedef.dart';

const APPLICATION_JSON = 'application/json';
const CONTENT_TYPE = 'content-type';
const ACCEPT = 'accept';
const AUTHORIZATION = 'Authorization';
const DEFAULT_LANGUAGE = 'language';
final Map<String, String> mainheaders = {
  CONTENT_TYPE: APPLICATION_JSON,
  ACCEPT: '*/*',
  DEFAULT_LANGUAGE: 'en',
};
final Map<String, String> weatherBaseQueryParams = {
  "hourly": "temperature_2m",
  "daily": "weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset",
  "timezone": "auto",
  "past_days": "1"
};

final Map<String, String> geoCodeBaseQueryParams = {
  "api_key": "66bc98dc50b72651389992bnc3ff8c0",
};

class ApiService {
  late Dio _dio;
  Dio get dio => _dio;

  static final ApiService _weather = ApiService._internalWeather();
  factory ApiService.weather() {
    return _weather;
  }
  ApiService._internalWeather() {
    print("ApiService._internalUser");
    _dio = Dio(BaseOptions(
      headers: mainheaders,
      baseUrl: "https://api.open-meteo.com/v1",
      sendTimeout: Duration(seconds: 30),
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ))
      ..interceptors.addAll([LoggerInterceptor()]);
  }

  //

  static final ApiService _geoCoder = ApiService._internalGeoCoder();
  factory ApiService.geoCoder() {
    return _geoCoder;
  }
  ApiService._internalGeoCoder() {
    _dio = Dio(BaseOptions(
      headers: mainheaders,
      baseUrl: "https://geocode.maps.co",
      sendTimeout: Duration(seconds: 30),
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ))
      ..interceptors.addAll([LoggerInterceptor()]);
  }

  Future<Response> _get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(url,
        queryParameters: {...?queryParameters}, options: Options());
  }

  Future<Response> _post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    FormData? formData,
    bool isFormData = false,
  }) async {
    return await dio.post(url,
        data: isFormData ? formData : data,
        queryParameters: {...?queryParams},
        options: Options());
  }

  ResultFuture<T> post<T>(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    required MapFunction<T> mapFunction,
    bool isFormData = false,
    FormData? formData,
  }) async {
    try {
      final response = await _post(url,
          data: data, isFormData: isFormData, formData: formData);
      if (response.statusCode == 200) {
        final data = mapFunction(response.data['data']);
        return Right(data);
      } else {
        return Left(ApiFailure(
            cause: response.statusMessage ?? '',
            responseCode: response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(
          cause: e.message ?? '', responseCode: e.response?.statusCode ?? 0));
    } catch (e) {
      return Left(ApiFailure(cause: e.toString() ?? '', responseCode: 0));
    }
  }

  ResultFuture<T> get<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    required MapFunction<T> mapFunction,
  }) async {
    try {
      final response = await _get(url, queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = mapFunction(response.data);
        return Right(data);
      } else {
        return Left(ApiFailure(
            cause: response.statusMessage ?? '',
            responseCode: response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(
          cause: e.message ?? '', responseCode: e.response?.statusCode ?? 0));
    } catch (e) {
      return Left(ApiFailure(cause: e.toString() ?? '', responseCode: 0));
    }
  }
}
