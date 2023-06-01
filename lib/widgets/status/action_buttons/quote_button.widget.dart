import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/compose/compose_status.widget.dart';

class QuoteButtonWidget extends StatelessWidget {
  const QuoteButtonWidget({required this.status, Key? key}) : super(key: key);
  final Status status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OpenContainer(
          closedColor: Colors.transparent,
          closedBuilder: (BuildContext context, VoidCallback openAction) {
            return IconButton(
              onPressed: openAction,
              icon: const Icon(
                Icons.format_quote_outlined,
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback openAction) {
            return ComposeStatusWidget(quotedStatus: status.reblog ?? status);
          },
          closedElevation: 0,
        ),
      ],
    );
  }
}
