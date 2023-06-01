import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/pages/account.page.dart';
import 'package:my_toots/services/api.service.dart';

class StatusHtmlTextWidget extends StatelessWidget {
  const StatusHtmlTextWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Html(
          data: status.content,
          onLinkTap: (url, attributes, element) {
            // print(context);
            // print(attributes);
            // print(element);
            // print('display');
            if (attributes.containsKey('class')) {
              if (attributes['class']!.contains('hashtag')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('👷 Hashtags not implemented yet 👷'),
                  ),
                );
                return;
              }
              if (attributes['class']!.contains('mention')) {
                List<String> splitted = url!.split('/');
                getIt
                    .get<ApiService>()
                    .findUserByUsername(splitted[2], splitted[3])
                    .then((Account found) => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AccountPage(account: found),
                            ),
                          )
                        });
              }
            }
          },
        ),
      ],
    );
  }
}
