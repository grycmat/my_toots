import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/reblog.widget.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';
import 'package:my_toots/widgets/status_html_text.widget.dart';

class StatusInNotificationWidget extends StatelessWidget {
  const StatusInNotificationWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 4, 12),
                child: status.reblog == null
                    ? StatusHtmlTextWidget(status: status)
                    : Center(
                        child: ReblogWidget(
                          status: status.reblog!,
                          rebloggerAcct: status.account.acct,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
