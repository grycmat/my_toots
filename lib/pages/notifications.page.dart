import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/favorite_notification.widget.dart';
import 'package:my_toots/widgets/follow_notification.widget.dart';
import 'package:my_toots/widgets/mention_notification.widget.dart';
import 'package:my_toots/widgets/poll_notification.widget.dart';
import 'package:my_toots/widgets/reblog_notification.widget.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';
import 'package:my_toots/widgets/status_in_notification.widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<AccountNotification> _notifications = [];

  Future<void> _getNotifications() async {
    return getIt.get<ApiService>().getNotifications().then((notifications) {
      print(notifications);
      setState(() {
        _notifications = notifications;
      });
      return Future.value();
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final noti = _notifications[index];
            if (noti.type == 'follow') {
              return FollowNotificationWidget(noti: noti);
            }
            if (noti.type == 'favourite') {
              return FavoriteNotificationWidget(noti: noti);
            }
            if (noti.type == 'reblog') {
              return ReblogNotificationWidget(noti: noti);
            }
            if (noti.type == 'mention') {
              return MentionNotificationWidget(noti: noti);
            }
            if (noti.type == 'poll') {
              return PollNotificationWidget(noti: noti);
            }
            if (noti.type == 'follow_request') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Follow request'),
                  StatusAccountRowWidget(account: noti.account),
                ],
              );
            }
            if (noti.type == 'status') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Enabled post notifications'),
                  StatusAccountRowWidget(account: noti.account),
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
            if (noti.type == 'update') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Status updated'),
                  StatusAccountRowWidget(account: noti.account),
                ],
              );
            }
            return const Text(
                'This type of notification is not implemented yet :(');
          },
          separatorBuilder: (context, index) =>
              const Divider(height: 5, thickness: 2),
          itemCount: _notifications.length),
    );
  }
}
