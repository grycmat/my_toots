import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/media_attachment.widget.dart';
import 'package:my_toots/widgets/status_html_text.widget.dart';

class ReblogWidget extends StatelessWidget {
  ReblogWidget({required this.status, Key? key}) : super(key: key);
  Status status;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade100,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.repeat_outlined),
                ),
                Text(
                  status.account.acct,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Color(0xFF101213),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: StatusHtmlTextWidget(status: status)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MediaAttachmentWidget(
                  mediaAttachments: status.mediaAttachments),
            ),
          ],
        ),
      ),
    );
  }
}