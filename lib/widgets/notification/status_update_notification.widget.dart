import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/notification/status_in_notification.widget.dart';
import 'package:my_toots/widgets/status/status_account_row.widget.dart';

class StatusUpdateNotificationWidget extends StatelessWidget {
  const StatusUpdateNotificationWidget({required this.noti, Key? key})
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
                Icons.edit_note_outlined,
                size: 32,
                color: Colors.purple.shade400,
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
                      compactProfile: true,
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
