import 'package:http/http.dart';
import 'dart:convert' show json;

import 'package:neko_poster/services/api/basic_api_service.dart';
import 'package:neko_poster/services/api/rapid_api_service_exceptions.dart';

class RapidApiService extends BasicApiService {
  RapidApiService(super.apiUrlString);

  Future<String> register({
    required String username,
    required String password,
  }) async {
    final Response response = await super.post(method: "registration", body: {
      "username": username,
      "password": password,
    });
    switch (response.statusCode) {
      case 200:
        break;

      // Other cases

      case 500:
        throw InternalServerError();
      default:
        throw UnknownResponseCode(response.statusCode);
    }
    return json.decode(response.body)["access_token"];
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    final Response response = await super.post(method: "login", body: {
      "username": username,
      "password": password,
    });
    switch (response.statusCode) {
      case 200:
        break;

      // Other cases

      case 500:
        throw InternalServerError();
      default:
        throw UnknownResponseCode(response.statusCode);
    }
    return json.decode(response.body)["access_token"];
  }
}
