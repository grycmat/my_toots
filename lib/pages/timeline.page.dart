import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status_container.widget.dart';
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
    super.initState();
    _getStatuses().then((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent - 200) {
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
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onRefresh: () => _getStatuses(),
        child: ListView.separated(
          primary: false,
          addAutomaticKeepAlives: true,
          padding: const EdgeInsets.all(8),
          cacheExtent: 200,
          separatorBuilder: (_, index) =>
              const Divider(height: 5, thickness: 2),
          controller: _scrollController,
          itemCount: _isLoading ? 20 : statuses.length + 1,
          itemBuilder: (_, index) {
            if (index == statuses.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (!_isLoading) {
              return StatusContainerWidget(
                status: statuses[index],
              );
            }
            return const StatusPlaceholderWidget();
          },
        ),
      ),
    );
  }
}
