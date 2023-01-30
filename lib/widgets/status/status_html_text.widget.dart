import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/pages/account.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/link_preview.widget.dart';

class StatusHtmlTextWidget extends StatelessWidget {
  const StatusHtmlTextWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    final Document htmlData = parse(status.content);
    final linkToDisplay =
        htmlData.querySelector("a[rel='nofollow noopener noreferrer']");

    return Column(
      children: [
        Html(
          data: status.content,
          onLinkTap: (url, renderContext, attributes, element) {
            if (attributes.containsKey('class') &&
                attributes['class']!.contains('mention')) {
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
            print(context);
            print(attributes);
            print(element);
            print('display');
            print(linkToDisplay);
          },
        ),
        linkToDisplay != null
            ? LinkPreviewWidget(element: linkToDisplay)
            : const SizedBox(),
      ],
    );
  }
}
