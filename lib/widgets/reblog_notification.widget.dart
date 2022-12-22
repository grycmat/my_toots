import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';
import 'package:my_toots/widgets/status_in_notification.widget.dart';

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.arrow_turn_up_right,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: StatusAccountRowWidget(account: noti.account),
            ),
          ],
        ),
        Card(
          elevation: 1,
          color: Theme.of(context).primaryColorLight,
          child: StatusInNotificationWidget(
            status: noti.status!,
          ),
        ),
      ],
    );
  }
}
