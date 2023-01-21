import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/favorite_notification.widget.dart';
import 'package:my_toots/widgets/follow_notification.widget.dart';
import 'package:my_toots/widgets/mention_notification.widget.dart';
import 'package:my_toots/widgets/no_connection_icon.widget.dart';
import 'package:my_toots/widgets/poll_notification.widget.dart';
import 'package:my_toots/widgets/reblog_notification.widget.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';
import 'package:my_toots/widgets/status_in_notification.widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  List<AccountNotification> _notifications = [];
  bool _error = false;

  Future<void> _getNotifications() async {
    if (!mounted) {
      return;
    }
    return getIt.get<ApiService>().getNotifications().then((notifications) {
      setState(() {
        _notifications = notifications;
      });
      return Future.value();
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ooops! No internet connection!'),
        ),
      );
      setState(() {
        _error = true;
      });
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
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onRefresh: () => _getNotifications(),
        child: _error
            ? const NoConnectionIconWidget()
            : ListView.separated(
                itemBuilder: (context, index) {
                  final noti = _notifications[index];

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
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Status updated'),
                          StatusAccountRowWidget(account: noti.account),
                        ],
                      );
                    default:
                      return const Text(
                          'This type of notification is not implemented yet :(');
                  }
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 5, thickness: 2),
                itemCount: _notifications.length),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
