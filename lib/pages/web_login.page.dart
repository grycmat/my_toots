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
  late WebViewController controller;
  Future<Map<String, Object>> _prepareAppCredentials() =>
      getIt.get<ApiService>().prepareAppCredentials(widget.instance);

  @override
  void initState() {
    print(widget.instance);
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest navigation) {
            if (navigation.url.startsWith(REDIRECT_URL)) {
              NavigationDecision.prevent;
              var uri = Uri.parse(navigation.url);
              var code = uri.queryParameters['code'];
              getIt.get<ApiService>().userAuthCode = code!;
              getIt.get<ApiService>().authorizeUser(code)!.then((value) {
                getIt.get<ApiService>().userToken = Token.fromMap(value.data);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                    (route) => false);
              });
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

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
            return WebViewWidget(
              controller: controller
                ..loadRequest(Uri.parse(
                    getIt.get<ApiService>().getLoginUrl(widget.instance))),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
