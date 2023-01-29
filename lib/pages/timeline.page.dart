import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/divider_separator.dart';
import 'package:my_toots/widgets/no_connection_icon.widget.dart';
import 'package:my_toots/widgets/status_container.widget.dart';
import 'package:my_toots/widgets/status_placeholder.widget.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage>
    with AutomaticKeepAliveClientMixin {
  List<Status> _statuses = [];
  bool _isLoading = true;
  bool _error = false;
  late final ScrollController _scrollController = ScrollController();

  Future<void> _getStatuses() async {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    return getIt.get<ApiService>().getHomeTimeline().then((statuses) {
      setState(() {
        _statuses = statuses;
        _isLoading = false;
      });
      print('refreshed');
      return Future.value();
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ooops! No internet connection!'),
        ),
      );
      setState(() {
        _error = true;
      });
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
              .getHomeTimeline(maxId: _statuses.last.id)
              .then((statuses) {
            setState(() {
              _statuses = [..._statuses, ...statuses];
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
        child: _error
            ? const Center(child: NoConnectionIconWidget())
            : ListView.separated(
                primary: false,
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.all(8),
                cacheExtent: 200,
                separatorBuilder: (_, index) => const DividerSeparator(),
                controller: _scrollController,
                itemCount: _isLoading ? 20 : _statuses.length + 1,
                itemBuilder: (_, index) {
                  if (index == _statuses.length && !_isLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (!_isLoading) {
                    return StatusContainerWidget(
                      status: _statuses[index],
                    );
                  }

                  return const StatusPlaceholderWidget();
                },
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
