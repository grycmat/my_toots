import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/status/action_buttons/favorite_button.widget.dart';
import 'package:my_toots/widgets/status/action_buttons/quote_button.widget.dart';
import 'package:my_toots/widgets/status/action_buttons/reblog_button.widget.dart';
import 'package:my_toots/widgets/status/action_buttons/reply_button.widget.dart';
import 'package:my_toots/widgets/status/action_buttons/share_button.widget.dart';

class StatusActionIconButtonsWidget extends StatelessWidget {
  const StatusActionIconButtonsWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReplyButtonWidget(status: status),
        FavoriteButtonWidget(status: status),
        ReblogButtonWidget(status: status),
        QuoteButtonWidget(status: status),
        ShareButtonWidget(status: status),
        // todo implement additional actions
        // const Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Icon(
        //       Icons.more_vert_rounded,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
