import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/media/media_attachment.widget.dart';
import 'package:my_toots/widgets/reblog.widget.dart';
import 'package:my_toots/widgets/status/status_account_row.widget.dart';
import 'package:my_toots/widgets/status/status_action_icon_buttons.widget.dart';
import 'package:my_toots/widgets/status/status_html_text.widget.dart';
import 'package:my_toots/widgets/status/status_spoiler.dart';

class StatusWidget extends StatelessWidget {
  final Status status;
  final bool showSpoiler;
  const StatusWidget({required this.status, this.showSpoiler = false, Key? key})
      : super(key: key);

  List<Widget> _buildStatus() {
    if (showSpoiler == false && status.spoilerText != '') {
      return [
        StatusSpoiler(status: status),
        StatusActionIconButtonsWidget(status: status)
      ];
    }
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: status.reblog == null
            ? StatusHtmlTextWidget(status: status)
            : Center(
                child: ReblogWidget(
                  status: status.reblog!,
                  rebloggerAcct: status.account.acct,
                ),
              ),
      ),
      MediaAttachmentWidget(mediaAttachments: status.mediaAttachments),
      StatusActionIconButtonsWidget(status: status),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 4),
              child: StatusAccountRowWidget(
                  account: status.reblog == null
                      ? status.account
                      : status.reblog!.account)),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildStatus(),
            ),
          ),
        ],
      ),
    );
  }
}
