import 'dart:convert';

import 'package:http/http.dart';
import 'package:neko_poster/constants/backend_config.dart';
import 'package:neko_poster/services/api/rapid_api_service.dart';

class PostsService {
  final RapidApiService _rapidApiService;
  final String _accessKey;
  Map<String, String> get _authorizedHeader =>
      {'Authorization': 'Bearer $_accessKey'};

  PostsService(this._rapidApiService, this._accessKey);

  factory PostsService._hackathon(
    String accessKey,
  ) =>
      PostsService(
        RapidApiService(backendUrl),
        accessKey,
      );

  static PostsService getInstance(String accessKey) {
    return PostsService._hackathon(accessKey);
  }

// !WIP

  // Future<void> updateUser({required Map<String, String?> data}) async {
  //   await _rapidApiService.put(
  //     method: "user/update",
  //     body: data,
  //     headers: _authorizedHeader,
  //   );
  // }

  // Future<Map<String, dynamic>> getUserData() async {
  //   Response response = await _rapidApiService.get(
  //     method: "user/profile",
  //     headers: _authorizedHeader,
  //   );
  //   Map<String, dynamic> data =
  //       jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  //   return data;
  // }
}
