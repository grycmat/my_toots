import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/divider_separator.dart';
import 'package:my_toots/widgets/no_connection_icon.widget.dart';
import 'package:my_toots/widgets/status/status_container.widget.dart';
import 'package:my_toots/widgets/status/status_placeholder.widget.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage>
    with AutomaticKeepAliveClientMixin {
  List<Status> _statuses = [];
  bool _isLoading = true;
  bool _isFirstLoad = true;
  bool _error = false;
  late final ScrollController _scrollController;

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
        _isFirstLoad = false;
      });
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
    _scrollController = ScrollController();
    _getStatuses().then((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0 &&
            !_isLoading) {
          setState(() {
            _isLoading = true;
          });
          getIt
              .get<ApiService>()
              .getHomeTimeline(maxId: _statuses.last.id)
              .then((statuses) {
            setState(() {
              _isLoading = false;
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
                itemCount: _isFirstLoad ? 20 : _statuses.length,
                itemBuilder: (_, index) {
                  if (_isFirstLoad) {
                    return const StatusPlaceholderWidget();
                  }

                  return StatusContainerWidget(
                    status: _statuses[index],
                  );
                },
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
