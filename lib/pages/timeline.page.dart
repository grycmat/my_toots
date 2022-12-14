import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status_container.widget.dart';
import 'package:my_toots/widgets/status.widget.dart';
import 'package:my_toots/widgets/status_placeholder.widget.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  List<Status> statuses = [];
  bool _isLoading = true;
  late final ScrollController _scrollController = ScrollController();

  Future<void> _getStatuses() async {
    setState(() {
      _isLoading = true;
    });
    return getIt.get<ApiService>().getHomeTimeline().then((statuses) {
      setState(() {
        this.statuses = statuses;
        _isLoading = false;
      });
      return Future.value();
    });
  }

  @override
  void initState() {
    _getStatuses();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getIt
            .get<ApiService>()
            .getHomeTimeline(maxId: statuses.last.id)
            .then((statuses) {
          setState(() {
            this.statuses = [...this.statuses, ...statuses];
          });
          return Future.value();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onRefresh: () => _getStatuses(),
        child: ListView.separated(
          separatorBuilder: (_, index) =>
              const Divider(height: 5, thickness: 2),
          controller: _scrollController,
          itemCount: _isLoading ? 20 : statuses.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            return _isLoading
                ? const StatusPlaceholderWidget()
                : StatusContainerWidget(
                    status: statuses[index],
                  );
          },
        ),
      ),
    );
  }
}
