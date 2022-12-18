import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/account_basic_info.widget.dart';
import 'package:my_toots/widgets/status.widget.dart';
import 'package:my_toots/widgets/status_account_row.widget.dart';

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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.person_add,
                            size: 40,
                            color: Colors.blue.shade400,
                          ),
                        ),
                        Expanded(
                          child: AccountBasicInfoWidget(account: noti.account),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            if (noti.type == 'favourite') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite_outline_outlined,
                            size: 40,
                            color: Colors.red.shade400,
                          ),
                        ),
                        Expanded(
                            child:
                                StatusAccountRowWidget(account: noti.account)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1,
                      color: Colors.green.shade100,
                      child: StatusWidget(
                        status: noti.status!,
                        showActions: false,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (noti.type == 'reblog') {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.arrow_turn_up_right,
                            size: 40,
                            color: Colors.green.shade400,
                          ),
                        ),
                        Expanded(
                          child: StatusAccountRowWidget(account: noti.account),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 1,
                      color: Colors.green.shade100,
                      child: StatusWidget(
                        status: noti.status!,
                        showActions: false,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (noti.type == 'mention') {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 8),
                          child: Icon(Icons.message_outlined,
                              color: Theme.of(context).primaryColor, size: 40),
                        ),
                        Expanded(
                          child: StatusWidget(
                            status: noti.status!,
                            showActions: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            if (noti.type == 'poll') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Poll ended'),
                  StatusAccountRowWidget(account: noti.account),
                  Card(
                    elevation: 1,
                    color: Colors.green.shade100,
                    child: StatusWidget(
                      status: noti.status!,
                      showActions: false,
                    ),
                  ),
                ],
              );
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
                    color: Colors.green.shade100,
                    child: StatusWidget(
                      status: noti.status!,
                      showActions: false,
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
