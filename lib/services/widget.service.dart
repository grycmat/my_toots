import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/compose/compose_status.widget.dart';
import 'package:my_toots/widgets/status/status_details.widget.dart';
import 'package:animations/animations.dart';

@singleton
class WidgetService {
  Widget getDetailsSheet(BuildContext context, Status status) {
    return SizedBox(
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

  Widget getComposeWidget() => OpenContainer(
        closedBuilder: (BuildContext context, VoidCallback openAction) {
          return IconButton(
            onPressed: openAction,
            icon: const Icon(
              Icons.mode_comment_outlined,
            ),
          );
        },
        openBuilder: (BuildContext context, VoidCallback openAction) {
          return const ComposeStatusWidget();
        },
        closedElevation: 0,
      );

  // Widget getComposeWidget(
  //         {required BuildContext context,
  //         Status? inReplyToStatus,
  //         Status? quotedStatus}) =>
  //     SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.95,
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Theme.of(context).primaryColor,
  //               ),
  //               width: 70,
  //               height: 5,
  //             ),
  //           ),
  //           Expanded(
  //             child: ComposeStatusWidget(
  //               inReplyToStatus: inReplyToStatus,
  //               quotedStatus: quotedStatus,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
