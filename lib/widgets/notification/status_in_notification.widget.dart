import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/widget.service.dart';
import 'package:my_toots/widgets/reblog.widget.dart';
import 'package:my_toots/widgets/status/status_account_row.widget.dart';
import 'package:my_toots/widgets/status/status_action_icon_buttons.widget.dart';
import 'package:my_toots/widgets/status/status_html_text.widget.dart';

class StatusInNotificationWidget extends StatelessWidget {
  const StatusInNotificationWidget(
      {required this.status, this.showActions = false, Key? key})
      : super(key: key);
  final Status status;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        context: context,
        builder: (context) =>
            getIt.get<WidgetService>().getDetailsSheet(context, status),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 4),
            child: StatusAccountRowWidget(account: status.account),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
          showActions
              ? StatusActionIconButtonsWidget(status: status)
              : const SizedBox()
        ],
      ),
    );
  }
}
