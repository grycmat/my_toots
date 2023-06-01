import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/no_connection_icon.widget.dart';
import 'package:my_toots/widgets/notifications_list.widget.dart';
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

  @override
  void initState() {
    _getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _isFirstLoad
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < 2; i++) const StatusPlaceholderWidget()
            ],
          )
        : Center(
            child: RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                color: Colors.white,
                onRefresh: () => _getNotifications(),
                child: _error
                    ? const Center(child: NoConnectionIconWidget())
                    : NotificationsListWidget(notifications: _notifications)
                // : ListView.separated(
                //     padding: const EdgeInsets.all(8),
                //     addAutomaticKeepAlives: true,
                //     cacheExtent: 200,
                //     separatorBuilder: (_, index) => const DividerSeparator(),
                //     itemCount: _isFirstLoad ? 20 : _notifications.length,
                //     itemBuilder: (context, index) {
                //       if (_isFirstLoad) {
                //         return const StatusPlaceholderWidget();
                //       }

                //       return _selectNotiType(_notifications[index]);
                //     },
                //   ),
                ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
