import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/created_app.dart';
import 'package:my_toots/models/o_auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class ApiService {
  CreatedApp? _createdApp;
  OAuthResponse? _appOAuth;
  String? _userAuthCode;
  String? _instance;
  OAuthResponse? _userOAuth;

  set userAuthCode(String token) => _userAuthCode = token;
  set userOAuth(OAuthResponse resp) => _userOAuth = resp;

  Future<Response> getPublicApi(String instance) {
    return Dio().get('https://$instance/api/v1/timelines/public');
  }

  Future<Response> getSampleInstances() {
    var apiKey = dotenv.env['INSTANCES_SEARCH_API'];
    return Dio().get('https://instances.social/api/1.0/instances/sample',
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
        }));
  }

  Future<Response> searchInstances(String term) {
    var apiKey = dotenv.env['INSTANCES_SEARCH_API'];
    return Dio().get('https://instances.social/api/1.0/instances/search',
        queryParameters: {'q': term},
        options: Options(headers: {
          'Authorization': 'Bearer $apiKey',
        }));
  }

  Future<Response> createApp(String instance) {
    return Dio().post('https://$instance/api/v1/apps', data: {
      'client_name': 'My Toots',
      'redirect_uris': 'com.mytoots://oauth',
      'scopes': 'read write follow push',
    });
  }

  Future<Response> getOAuthToken(String instance, CreatedApp app) {
    return Dio().post('https://$instance/oauth/token', data: {
      'client_id': app.clientId,
      'client_secret': app.clientSecret,
      'grant_type': 'client_credentials',
    });
  }

  Future<Map<String, Object>> prepareAppCredentials(String instance) async {
    _instance = instance;
    final prefs = getIt.get<SharedPreferences>();
    prefs.setString('instance', instance);
    var createAppResponse = await createApp(instance);
    var app = CreatedApp.fromMap(createAppResponse.data);
    _createdApp = app;
    prefs.setString('app', jsonEncode(app));
    var tokenResponse = await getOAuthToken(instance, app);
    var oAuth = OAuthResponse.fromMap(tokenResponse.data);
    _appOAuth = oAuth;
    prefs.setString('appOAuth', jsonEncode(oAuth));

    return {'app': app, 'oAuth': oAuth};
  }

  String getLoginUrl(String instance) {
    return 'https://$instance/oauth/authorize?client_id=${_createdApp!.clientId}&redirect_uri=com.mytoots://oauth&response_type=code&scope=read+write+follow+push';
  }

  Future<Response> getMe() async {
    final response = await Dio().get(
      'https://$_instance/api/v1/accounts/verify_credentials',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userOAuth!.accessToken}'}),
    );
    final account = Account.fromMap(response.data);
    final prefs = getIt.get<SharedPreferences>();
    prefs.setString('user', jsonEncode(account));
    return response;
  }

  Future<Response> authorizeUser(String code) {
    _userAuthCode = code;
    return Dio().post('https://$_instance/oauth/token', data: {
      'client_id': _createdApp!.clientId,
      'client_secret': _createdApp!.clientSecret,
      'redirect_uri': 'com.mytoots://oauth',
      'grant_type': 'authorization_code',
      'code': _userAuthCode,
      'scope': 'read write follow push'
    });
  }

  getHomeTimeline() {
    return Dio().get(
      'https://$_instance/api/v1/timelines/home',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userOAuth!.accessToken}'}),
    );
  }
}
