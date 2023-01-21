import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/account_basic_info.widget.dart';

class FollowNotificationWidget extends StatelessWidget {
  const FollowNotificationWidget({required this.noti, Key? key})
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
                CupertinoIcons.person_add,
                size: 36,
                color: Colors.blue.shade400,
              ),
            ),
            Expanded(
              child: AccountBasicInfoWidget(account: noti.account),
            ),
          ],
        ),
      ],
    );
  }
}
