import 'package:dio/dio.dart';

class ApiService{
    final dio = Dio();
    final String baseUrl = "http://127.0.0.1:5000/";

    Future<Response> getFirstLogin(int uid) async {
        return await dio.get("${baseUrl}firstLogin/$uid");
    }

     Future<Response> getUpdatePriorit(int uid) async {
        return await dio.get("${baseUrl}updatePriorit/$uid");
    }

  Future<Response> sendNotification(String uid) async {
    return await dio.get("${baseUrl}sendnotificaion/$uid");
  }

}