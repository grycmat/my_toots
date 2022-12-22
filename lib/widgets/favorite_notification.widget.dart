import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';
import 'package:my_toots/widgets/status_in_notification.widget.dart';

class FavoriteNotificationWidget extends StatelessWidget {
  const FavoriteNotificationWidget({required this.noti, Key? key})
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
            Icon(
              Icons.favorite_outline_outlined,
              size: 25,
              color: Colors.red.shade400,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatusAccountRowWidget(account: noti.account),
                Card(
                  elevation: 1,
                  color: Theme.of(context).primaryColorLight,
                  child: StatusInNotificationWidget(
                    status: noti.status!,
                  ),
                ),
              ],
            )),
          ],
        ),
      ],
    );
  }
}
