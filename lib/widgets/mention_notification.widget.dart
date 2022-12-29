import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/status_in_notification.widget.dart';

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
            Icon(Icons.message_outlined,
                color: Colors.purple.shade200, size: 25),
            Expanded(
              child: StatusInNotificationWidget(
                status: noti.status!,
                showActions: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
