import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/account_basic_info.widget.dart';
import 'package:my_toots/widgets/status.widget.dart';
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.person_add,
                        size: 40,
                        color: Colors.blue.shade400,
                      ),
                      Expanded(
                        child: AccountBasicInfoWidget(account: noti.account),
                      ),
                    ],
                  ),
                ],
              );
            }
            if (noti.type == 'favourite') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite_outline_outlined,
                        size: 40,
                        color: Colors.red.shade400,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatusAccountRowWidget(account: noti.account),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 1,
                              color: Theme.of(context).primaryColorLight,
                              child: StatusInNotificationWidget(
                                status: noti.status!,
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              );
            }
            if (noti.type == 'reblog') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.arrow_turn_up_right,
                        size: 40,
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
            if (noti.type == 'mention') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.message_outlined,
                          color: Colors.purple.shade200, size: 40),
                      Expanded(
                        child: StatusInNotificationWidget(
                          status: noti.status!,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            if (noti.type == 'poll') {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.poll_outlined,
                        size: 40,
                        color: Colors.green.shade300,
                      ),
                      Expanded(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatusInNotificationWidget(
                            status: noti.status!,
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              for (var option in noti.status!.poll!.options!)
                                ListTile(
                                  title: Text(
                                      '${option.title} (${option.votesCount})'),
                                  subtitle: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      minHeight: 20,
                                      value: option.votesCount /
                                          noti.status!.poll!.votesCount,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ],
                      )),
                    ],
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
