import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status/status.widget.dart';

class StatusDetailsWidget extends StatefulWidget {
  final Status status;
  const StatusDetailsWidget(this.status, {Key? key}) : super(key: key);

  @override
  _StatusDetailsWidgetState createState() => _StatusDetailsWidgetState();
}

class _StatusDetailsWidgetState extends State<StatusDetailsWidget> {
  List<Status> _ancestors = [];
  final List<Status> _descendants = [];

  @override
  void initState() {
    _descendants.add(widget.status);
    getIt.get<ApiService>().getStatusContext(widget.status.id).then((value) {
      if (mounted) {
        setState(() {
          _ancestors = [...value.ancestors];
          _descendants.addAll(value.descendants);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('center-key');
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .9,
      child: CustomScrollView(
        center: centerKey,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Center(
                child: StatusWidget(
                    status: _ancestors[_ancestors.length - 1 - index]),
              );
            }, childCount: _ancestors.length),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate((context, index) {
              return _descendants[index].id == widget.status.id
                  ? Column(
                      children: [
                        _ancestors.isNotEmpty
                            ? Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons
                                          .subdirectory_arrow_right_outlined),
                                      Text(
                                        'In response to',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Center(
                          child: StatusWidget(
                            status: _descendants[index],
                            showSpoiler: true,
                          ),
                        ),
                        _descendants.length > 1
                            ? Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Replies',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer),
                                      ),
                                      const Icon(Icons
                                          .subdirectory_arrow_left_outlined),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )
                  : Center(
                      child: StatusWidget(status: _descendants[index]),
                    );
            }, childCount: _descendants.length),
          ),
        ],
      ),
    );
  }
}
