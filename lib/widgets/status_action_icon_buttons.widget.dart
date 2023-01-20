import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/services/widget.service.dart';

class StatusActionIconButtonsWidget extends StatefulWidget {
  const StatusActionIconButtonsWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  @override
  State<StatusActionIconButtonsWidget> createState() =>
      _StatusActionIconButtonsWidgetState();
}

class _StatusActionIconButtonsWidgetState
    extends State<StatusActionIconButtonsWidget> {
  late bool _isReblogged;
  late bool _isFavorited;

  @override
  void initState() {
    _isReblogged = widget.status.reblogged;
    _isFavorited = widget.status.favourited;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  context: context,
                  builder: (_) => getIt
                      .get<WidgetService>()
                      .getComposeWidget(inReplyToStatus: widget.status),
                );
              },
              icon: const Icon(
                Icons.mode_comment_outlined,
              ),
            ),
            Text(
              widget.status.repliesCount.toString(),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  final service = getIt.get<ApiService>();
                  setState(() {
                    _isFavorited = !_isFavorited;
                  });
                  service.toggleFavorite(
                      status: widget.status, favorite: _isFavorited);
                },
                icon: _isFavorited
                    ? const Icon(
                        Icons.favorite_outlined,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_outline_outlined)),
            Text(
              widget.status.favouritesCount.toString(),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                final service = getIt.get<ApiService>();
                setState(() {
                  _isReblogged = !_isReblogged;
                });
                service.toggleReblog(
                    status: widget.status, reblog: _isReblogged);
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
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.format_quote_outlined,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.share_outlined,
            ),
          ],
        ),
      ],
    );
  }
}
