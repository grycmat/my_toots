import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/divider_separator.dart';
import 'package:my_toots/widgets/notification/favorite_notification.widget.dart';
import 'package:my_toots/widgets/notification/follow_notification.widget.dart';
import 'package:my_toots/widgets/notification/mention_notification.widget.dart';
import 'package:my_toots/widgets/no_connection_icon.widget.dart';
import 'package:my_toots/widgets/notification/status_update_notification.widget.dart';
import 'package:my_toots/widgets/poll_notification.widget.dart';
import 'package:my_toots/widgets/notification/reblog_notification.widget.dart';
import 'package:my_toots/widgets/status/status_account_row.widget.dart';
import 'package:my_toots/widgets/notification/status_in_notification.widget.dart';
import 'package:my_toots/widgets/status/status_placeholder.widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  List<AccountNotification> _notifications = [];
  bool _error = false;
  bool _isFirstLoad = true;

  Future<void> _getNotifications() async {
    if (!mounted) {
      return;
    }
    return getIt.get<ApiService>().getNotifications().then((notifications) {
      setState(() {
        _notifications = notifications;
        _isFirstLoad = false;
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

  @override
  void initState() {
    _getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onRefresh: () => _getNotifications(),
        child: _error
            ? const NoConnectionIconWidget()
            : ListView.separated(
                padding: const EdgeInsets.all(8),
                addAutomaticKeepAlives: true,
                cacheExtent: 200,
                separatorBuilder: (_, index) => const DividerSeparator(),
                itemCount: _isFirstLoad ? 20 : _notifications.length,
                itemBuilder: (context, index) {
                  if (_isFirstLoad) {
                    return const StatusPlaceholderWidget();
                  }

                  return _selectNotiType(_notifications[index]);
                },
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
