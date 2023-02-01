import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/token.dart';
import 'package:my_toots/pages/home.page.dart';
import 'package:my_toots/pages/select_instance.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage(this.instance, {Key? key}) : super(key: key);
  final String instance;

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  Future<Map<String, Object>> _prepareAppCredentials() =>
      getIt.get<ApiService>().prepareAppCredentials(widget.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: FutureBuilder(
        future: _prepareAppCredentials(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not connect to this instance!'),
                ),
              );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SelectInstancePage(),
                  ),
                  (route) => false);
            });
            return Container();
          }
          if (snapshot.hasData) {
            return WebView(
                initialUrl:
                    getIt.get<ApiService>().getLoginUrl(widget.instance),
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (navigation) async {
                  if (navigation.url.startsWith(REDIRECT_URL)) {
                    var uri = Uri.parse(navigation.url);
                    var code = uri.queryParameters['code'];
                    getIt.get<ApiService>().userAuthCode = code!;
                    getIt.get<ApiService>().authorizeUser(code)!.then((value) {
                      getIt.get<ApiService>().userToken =
                          Token.fromMap(value.data);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ),
                          (route) => false);
                    });
                  }
                  return NavigationDecision.navigate;
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
