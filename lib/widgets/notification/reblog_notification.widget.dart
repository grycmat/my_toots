import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/status/status_account_row.widget.dart';
import 'package:my_toots/widgets/notification/status_in_notification.widget.dart';

class ReblogNotificationWidget extends StatelessWidget {
  const ReblogNotificationWidget({required this.noti, Key? key})
      : super(key: key);
  final AccountNotification noti;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.loop_outlined,
                size: 26,
                color: Colors.green.shade400,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusAccountRowWidget(account: noti.account),
                  Card(
                    elevation: 1,
                    child: StatusInNotificationWidget(
                      status: noti.status!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
