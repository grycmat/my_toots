import 'package:flutter/material.dart';
import 'package:my_toots/models/notification/account_notification.dart';
import 'package:my_toots/widgets/notification/status_in_notification.widget.dart';

class PollNotificationWidget extends StatelessWidget {
  const PollNotificationWidget({required this.noti, Key? key})
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
                Icons.poll_outlined,
                size: 26,
                color: Colors.amber.shade800,
              ),
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
                        dense: true,
                        title: Text('${option.title} (${option.votesCount})'),
                        subtitle: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            minHeight: 15,
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
}
