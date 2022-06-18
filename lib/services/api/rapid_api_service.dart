import 'package:http/http.dart';
import 'dart:convert' show json, utf8;

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
      case 400:
        throw UserAlreadyExists();
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

      case 404:
        throw UserDoesNotExist();
      case 403:
        throw WrongPassword();
      // Other cases

      case 500:
        throw InternalServerError();
      default:
        throw UnknownResponseCode(response.statusCode);
    }
    return json.decode(response.body)["access_token"];
  }

  Future<String> getUsername({required String accessToken}) async {
    final Response response = await super.get(
      method: "user/name",
      headers: {"Authorization": "Bearer $accessToken"},
    );
    switch (response.statusCode) {
      case 200:
        break;

      // Other cases

      case 500:
        throw InternalServerError();
      default:
        throw UnknownResponseCode(response.statusCode);
    }
    String res = json.decode(utf8.decode(response.bodyBytes));
    print(res);
    print(response.body);
    return res;
  }
}
