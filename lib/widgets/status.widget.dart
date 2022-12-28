import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/media_attachment.widget.dart';
import 'package:my_toots/widgets/reblog.widget.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';
import 'package:my_toots/widgets/status_action_icon_buttons.widget.dart';
import 'package:my_toots/widgets/status_html_text.widget.dart';

class StatusWidget extends StatelessWidget {
  final Status status;
  const StatusWidget({required this.status, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 4),
              child: StatusAccountRowWidget(account: status.account)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: status.reblog == null
                      ? StatusHtmlTextWidget(status: status)
                      : Center(
                          child: ReblogWidget(status: status.reblog!),
                        ),
                ),
                MediaAttachmentWidget(
                    mediaAttachments: status.mediaAttachments),
                StatusActionIconButtonsWidget(status: status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
