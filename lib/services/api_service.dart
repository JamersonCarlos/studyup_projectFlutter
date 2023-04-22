import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio();
  final String baseUrl = "http://192.168.0.106:8000/";

  Future<Response> getFirstLogin(String uid) async {
    return await dio.get("${baseUrl}firstLogin/$uid");
  }

  Future<Response> getUpdatePriorit(String uid) async {
    return await dio.get("${baseUrl}updatePriorit/$uid");
  }

  Future<Response> sendNotification(String uid) async {
    return await dio.get("${baseUrl}sendnotificaion/$uid");
  }
}
