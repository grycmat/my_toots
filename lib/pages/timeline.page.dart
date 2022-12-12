import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status.widget.container.dart';
import 'package:my_toots/widgets/status.widget.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Status> statuses = [];

  Future<void> _getStatuses() async {
    return getIt.get<ApiService>().getHomeTimeline().then((statuses) {
      print(statuses);
      setState(() {
        this.statuses = statuses;
      });
      return Future.value();
    });
  }

  @override
  void initState() {
    _getStatuses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onRefresh: () => _getStatuses(),
        child: ListView.builder(
          itemCount: statuses.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return StatusWidgetContainer(
              status: statuses[index],
            );
          },
        ),
      ),
    );
  }
}
