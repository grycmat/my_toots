import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/notification/favorite_notification.widget.dart';
import 'package:my_toots/widgets/notification/follow_notification.widget.dart';
import 'package:my_toots/widgets/notification/mention_notification.widget.dart';
import 'package:my_toots/widgets/notification/status_update_notification.widget.dart';
import 'package:my_toots/widgets/poll_notification.widget.dart';
import 'package:my_toots/widgets/notification/reblog_notification.widget.dart';
import 'package:my_toots/widgets/status/status_account_row.widget.dart';
import 'package:my_toots/widgets/notification/status_in_notification.widget.dart';

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({required this.notifications, Key? key})
      : super(key: key);
  final List<AccountNotification> notifications;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      cacheExtent: 20000,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _selectNotiType(
              notifications[index],
            ),
            childCount: notifications.length,
          ),
        ),
      ],
    );
  }

  Widget _selectNotiType(AccountNotification noti) {
    switch (noti.type) {
      case 'follow':
        return FollowNotificationWidget(noti: noti);
      case 'favourite':
        return FavoriteNotificationWidget(noti: noti);
      case 'reblog':
        return ReblogNotificationWidget(noti: noti);
      case 'mention':
        return MentionNotificationWidget(noti: noti);
      case 'poll':
        return PollNotificationWidget(noti: noti);
      case 'follow_request':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Follow request'),
            StatusAccountRowWidget(account: noti.account),
          ],
        );
      case 'status':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enabled post notifications'),
            StatusAccountRowWidget(account: noti.account),
            Card(
              elevation: 1,
              child: StatusInNotificationWidget(
                status: noti.status!,
              ),
            ),
          ],
        );
      case 'update':
        return StatusUpdateNotificationWidget(noti: noti);
      default:
        return const Text(
            'This type of notification is not implemented yet :(');
    }
  }
}
