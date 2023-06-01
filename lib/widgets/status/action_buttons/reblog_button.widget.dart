import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';

class ReblogButtonWidget extends StatefulWidget {
  const ReblogButtonWidget({required this.status, Key? key}) : super(key: key);
  final Status status;
  @override
  _ReblogButtonWidgetState createState() => _ReblogButtonWidgetState();
}

class _ReblogButtonWidgetState extends State<ReblogButtonWidget> {
  late bool _isReblogged;
  @override
  void initState() {
    _isReblogged = widget.status.reblogged ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async {
            final service = getIt.get<ApiService>();
            await service.toggleReblog(
                status: widget.status, reblog: !_isReblogged);
            setState(() {
              _isReblogged = !_isReblogged;
            });
          },
          icon: _isReblogged
              ? const Icon(
                  Icons.loop_outlined,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.loop_outlined,
                ),
        ),
        Text(
          widget.status.reblogsCount.toString(),
        ),
      ],
    );
  }
}
