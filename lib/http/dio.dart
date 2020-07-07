import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "http://127.0.0.1:9501",
  connectTimeout: 5000,
  receiveTimeout: 5000,
);
Dio dio = new Dio(options);