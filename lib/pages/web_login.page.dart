import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/search_instances/instance.dart';
import 'package:my_toots/pages/my_account.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage(this.instance, {Key? key}) : super(key: key);
  final Instance instance;

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  final _apiService = getIt.get<ApiService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _apiService.prepareAppCredentials(widget.instance.name),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return WebView(
              initialUrl: _apiService.getLoginUrl(widget.instance.name),
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (navigation) {
                if (navigation.url.startsWith('com.mytoots://oauth')) {
                  var uri = Uri.parse(navigation.url);
                  var code = uri.queryParameters['code'];
                  _apiService.userAuthCode = code!;

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MyAccountPage()));
                }
                return NavigationDecision.navigate;
              });
        }
        return Container();
      },
    );
  }
}
