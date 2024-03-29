import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/application.dart';
import 'package:my_toots/models/hashtag/hashtag.dart';
import 'package:my_toots/models/instance/instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/models/status/status_context.dart';
import 'package:my_toots/models/status/status_payload.dart';
import 'package:my_toots/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

const APPLICATION = 'application';
const USER_AUTH_CODE = 'user_auth_code';
const APP_TOKEN = 'appToken';
const USER_TOKEN = 'userToken';
const USER = 'user';
const INSTANCE = 'instance';
const REDIRECT_URL = 'app://com.tootoo';

@singleton
class ApiService {
  SharedPreferences _prefs;
  Application? _application;
  Token? _appToken;
  String? _userAuthCode;
  String? _instance;
  Token? _userToken;

  ApiService(
      {required SharedPreferences prefs,
      Application? application,
      Token? appToken,
      String? userAuthCode,
      String? instance,
      Token? userToken})
      : _prefs = prefs,
        _application = application,
        _appToken = appToken,
        _userAuthCode = userAuthCode,
        _instance = instance,
        _userToken = userToken;

  @factoryMethod
  factory ApiService.init(SharedPreferences prefs) {
    final application = prefs.getString(APPLICATION);
    final appToken = prefs.getString(APP_TOKEN);
    final instance = prefs.getString(INSTANCE);
    final userToken = prefs.getString(USER_TOKEN);

    return ApiService(
      prefs: prefs,
      application: application != null
          ? Application.fromMap(jsonDecode(application))
          : null,
      appToken: appToken != null ? Token.fromMap(jsonDecode(appToken)) : null,
      instance: instance,
      userToken:
          userToken != null ? Token.fromMap(jsonDecode(userToken)) : null,
    );
  }

  set application(Application value) {
    _prefs.setString(APPLICATION, value.toJson());
    _application = value;
  }

  set appToken(Token value) {
    _prefs.setString(APP_TOKEN, value.toJson());
    _appToken = value;
  }

  set userAuthCode(String value) {
    _userAuthCode = value;
  }

  set instance(String value) {
    _prefs.setString(INSTANCE, value);
    _instance = value;
  }

  set userToken(Token value) {
    _prefs.setString(USER_TOKEN, value.toJson());
    _userToken = value;
  }

  bool hasUserCredentials() {
    return _userToken != null && _instance != null;
  }

  Future<Account> findUserByUsername(String userInstance, String user) async {
    final response = await Dio().get(
      'https://$_instance/api/v1/accounts/search?q=$user@$userInstance&limit=1',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    return Account.fromMap(response.data[0]);
  }

  Future<List<Object>> search(String query, String type) async {
    final response = await Dio().get(
      'https://$_instance/api/v2/search',
      queryParameters: {'q': query, 'type': type},
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );

    if (type == 'accounts') {
      return (response.data['accounts'] as List)
          .map((e) => Account.fromMap(e))
          .toList();
    }

    if (type == 'statuses') {
      return (response.data['statuses'] as List)
          .map((e) => Status.fromMap(e))
          .toList();
    }

    return (response.data['hashtags'] as List)
        .map((e) => Hashtag.fromMap(e))
        .toList();
  }

  Future<List<Status>> getPublicTimeline() async {
    final response =
        await Dio().get('https://$_instance/api/v1/timelines/public?limit=40');

    return (response.data as List).map((e) => Status.fromMap(e)).toList();
  }

  Future<List<Account>> getFollowers(String accountId) async {
    final response = await Dio()
        .get('https://$_instance/api/v1/accounts/$accountId/following');
    final items = response.data as List<dynamic>;

    return items.map((e) => Account.fromMap(e)).toList();
  }

  Future<List<Account>> getFollowing(String accountId) async {
    final response = await Dio()
        .get('https://$_instance/api/v1/accounts/$accountId/following');
    final items = response.data as List<dynamic>;

    return items.map((e) => Account.fromMap(e)).toList();
  }

  Future<Instance> getInstance() async {
    final response = await Dio().get('https://$_instance/api/v1/instance');
    return Instance.fromMap(response.data);
  }

  Future<Response> getConversations() {
    return Dio().get('https://$_instance/api/v1/conversations');
  }

  Future<Application> createApp(String instance) async {
    final response = await Dio().post('https://$instance/api/v1/apps', data: {
      'client_name': 'My Toots',
      'redirect_uris': REDIRECT_URL,
      'scopes': 'read write follow push',
    });
    application = Application.fromMap(response.data);

    return _application!;
  }

  Future<Token> getAppToken(String instance, Application app) async {
    final response = await Dio().post('https://$instance/oauth/token', data: {
      'client_id': app.clientId,
      'client_secret': app.clientSecret,
      'grant_type': 'client_credentials',
    });

    appToken = Token.fromMap(response.data);

    return _appToken!;
  }

  Future<Map<String, Object>> prepareAppCredentials(String i) async {
    instance = i;
    final app = await createApp(i);
    final appToken = await getAppToken(i, app);

    return {'app': app, 'token': appToken};
  }

  String getLoginUrl(String instance) {
    return 'https://$instance/oauth/authorize?client_id=${_application!.clientId}&redirect_uri=$REDIRECT_URL&response_type=code&scope=read+write+follow+push';
  }

  Future<Account> getMe() async {
    final response = await Dio().get(
      'https://$_instance/api/v1/accounts/verify_credentials',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    return Account.fromMap(response.data);
  }

  Future<Response>? authorizeUser(String code) {
    userAuthCode = code;
    return Dio().post('https://$_instance/oauth/token', data: {
      'client_id': _application!.clientId,
      'client_secret': _application!.clientSecret,
      'redirect_uri': REDIRECT_URL,
      'grant_type': 'authorization_code',
      'code': _userAuthCode,
      'scope': 'read write follow push'
    });
  }

  Future<List<AccountNotification>> getNotifications() async {
    final response = await Dio().get(
      'https://$_instance/api/v1/notifications?limit=30',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    final items = response.data as List<dynamic>;

    return items.map((e) => AccountNotification.fromMap(e)).toList();
  }

  Future<List<Status>> getHomeTimeline({String? maxId}) async {
    if (maxId != null) {
      final response = await Dio().get(
        'https://$_instance/api/v1/timelines/home?max_id=$maxId&limit=40',
        options: Options(
            headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
      );
      final items = response.data as List<dynamic>;

      return items.map((e) => Status.fromMap(e)).toList();
    }

    final response = await Dio().get(
      'https://$_instance/api/v1/timelines/home?limit=40',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    final items = response.data as List<dynamic>;

    return items.map((e) => Status.fromMap(e)).toList();
  }

  Future<StatusContext> getStatusContext(String id) async {
    final response = await Dio().get(
      'https://$_instance/api/v1/statuses/$id/context',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    return StatusContext.fromMap(response.data);
  }

  Future<Response> postStatus(StatusPayload status) {
    return Dio().post(
      'https://$_instance/api/v1/statuses',
      data: status.toMap(),
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
  }

  Future<Account> getAccount(String id) async {
    final accountResponse = await Dio().get(
      'https://$_instance/api/v1/accounts/$id',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    return Account.fromMap(accountResponse.data);
  }

  Future<Response> lookupAccount(String name, String instance) {
    return Dio().get(
      'https://$instance/api/v1/accounts/lookup?acct=$name',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
  }

  Future<List<Status>> getTimelineById(String id) async {
    final response = await Dio().get(
      'https://$_instance/api/v1/accounts/$id/statuses',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
    final items = response.data as List<dynamic>;

    return items.map((e) => Status.fromMap(e)).toList();
  }

  Future<Response> toggleFavorite(
      {required Status status, required bool favorite}) {
    return favorite
        ? Dio().post(
            'https://$_instance/api/v1/statuses/${status.id}/favourite',
            options: Options(headers: {
              'Authorization': 'Bearer ${_userToken!.accessToken}'
            }),
          )
        : Dio().post(
            'https://$_instance/api/v1/statuses/${status.id}/unfavourite',
            options: Options(headers: {
              'Authorization': 'Bearer ${_userToken!.accessToken}'
            }),
          );
  }

  Future<Response> toggleReblog({required Status status, required reblog}) {
    return reblog
        ? Dio().post(
            'https://$_instance/api/v1/statuses/${status.id}/reblog',
            options: Options(headers: {
              'Authorization': 'Bearer ${_userToken!.accessToken}'
            }),
          )
        : Dio().post(
            'https://$_instance/api/v1/statuses/${status.id}/unreblog',
            options: Options(headers: {
              'Authorization': 'Bearer ${_userToken!.accessToken}'
            }),
          );
  }

  Future<Response> undoBoostStatus(Status status) {
    return Dio().post(
      'https://$_instance/api/v1/statuses/${status.id}/unreblog',
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
    );
  }

  Future<Response> uploadFile(
      {required File file,
      void Function({int count, int total})? callback}) async {
    final fileData = await MultipartFile.fromFile(file.path);

    final formData = FormData.fromMap({
      'file': fileData,
    });

    return Dio().post(
      'https://$_instance/api/v2/media',
      data: formData,
      options: Options(
          headers: {'Authorization': 'Bearer ${_userToken!.accessToken}'}),
      onSendProgress: (count, total) {
        if (callback != null) callback(count: count, total: total);
        print('count: $count, total: $total');
      },
    );
  }

  Future<List<Response>> uploadFiles(List<File> files) {
    return Future.wait([for (var file in files) uploadFile(file: file)]);
  }

  Future<bool> logout() {
    return _prefs.clear();
  }

  _requestWithToken() {}
}
