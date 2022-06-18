import 'package:neko_poster/constants/backend_config.dart';
import 'package:neko_poster/services/api/rapid_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const accessKeyPreference = 'access_key';

// Encapsulates SharedPreferences to deal with credentials and etc.
class SharedPreferencesAuthService {
  final RapidApiService _rapidApiService;
  final SharedPreferences _sharedPreferences;

  SharedPreferencesAuthService(this._rapidApiService, this._sharedPreferences);
  factory SharedPreferencesAuthService._hackathon(
    SharedPreferences sharedPreferences,
  ) =>
      SharedPreferencesAuthService(
        RapidApiService(backendUrl),
        sharedPreferences,
      );

  static Future<SharedPreferencesAuthService> getInstance() async {
    return SharedPreferencesAuthService._hackathon(
      await SharedPreferences.getInstance(),
    );
  }

  Future<void> register({
    required String username,
    required String password,
  }) async {
    final String accessKey = await _rapidApiService.register(
      username: username,
      password: password,
    );
    await _sharedPreferences.setString(
      accessKeyPreference,
      accessKey,
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final String accessKey = await _rapidApiService.login(
      username: username,
      password: password,
    );
    await _sharedPreferences.setString(
      accessKeyPreference,
      accessKey,
    );
  }

  void logout() {
    _sharedPreferences.remove(accessKeyPreference);
  }

  bool isUserLoggedIn() {
    final String accessKey = currentAccessKey ?? "";
    return accessKey.isNotEmpty;
  }

  Future<String> get userName async =>
      _rapidApiService.getUsername(accessToken: currentAccessKey ?? "");

  String? get currentAccessKey =>
      _sharedPreferences.getString(accessKeyPreference);
}
