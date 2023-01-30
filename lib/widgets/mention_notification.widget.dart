import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/status/status_in_notification.widget.dart';

class MentionNotificationWidget extends StatelessWidget {
  const MentionNotificationWidget({required this.noti, Key? key})
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
            Expanded(
              child: StatusInNotificationWidget(
                status: noti.status!,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
