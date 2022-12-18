import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/models/status/status_context.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status.widget.dart';

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
      setState(() {
        _ancestors = [...value.ancestors];
        _descendants.addAll(value.descendants);
      });
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
                child: StatusWidget(status: _ancestors[index]),
              );
            }, childCount: _ancestors.length),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate((context, index) {
              return _descendants[index].id == widget.status.id
                  ? Column(
                      children: [
                        Container(
                          color: Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(Icons.subdirectory_arrow_right_outlined),
                                Text('In response to'),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: StatusWidget(status: _descendants[index]),
                        ),
                        Container(
                          color: Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text('Replies'),
                                Icon(Icons.subdirectory_arrow_left_outlined),
                              ],
                            ),
                          ),
                        ),
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
