import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/status/status_container.widget.dart';

class TimelineListWidget extends StatelessWidget {
  const TimelineListWidget({Key? key, required this.statuses})
      : super(key: key);
  final List<Status> statuses;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      cacheExtent: 20000,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => StatusContainerWidget(
              status: statuses[index],
            ),
            childCount: statuses.length,
          ),
        ),
      ],
    );
  }
}
