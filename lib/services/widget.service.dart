import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/compose_status.widget.dart';
import 'package:my_toots/widgets/status_details.widget.dart';

@singleton
class WidgetService {
  Widget getDetailsSheet(BuildContext context, Status status) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              width: 70,
              height: 5,
            ),
          ),
          Expanded(child: StatusDetailsWidget(status)),
        ],
      ),
    );
  }

  Widget getComposeWidget({Status? inReplyToStatus}) =>
      ComposeStatusWidget(inReplyToStatus: inReplyToStatus);
}
