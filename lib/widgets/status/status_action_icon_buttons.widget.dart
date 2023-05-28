import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/compose/compose_status.widget.dart';
import 'package:share_plus/share_plus.dart';

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
    _isReblogged = widget.status.reblogged ?? false;
    _isFavorited = widget.status.favourited ?? false;
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
            OpenContainer(
              closedColor: Colors.transparent,
              closedBuilder: (BuildContext context, VoidCallback openAction) {
                return IconButton(
                  onPressed: openAction,
                  icon: const Icon(
                    Icons.mode_comment_outlined,
                  ),
                );
              },
              openBuilder: (BuildContext context, VoidCallback openAction) {
                return ComposeStatusWidget(inReplyToStatus: widget.status);
              },
              closedElevation: 0,
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
          children: [
            OpenContainer(
              closedColor: Colors.transparent,
              closedBuilder: (BuildContext context, VoidCallback openAction) {
                return IconButton(
                  onPressed: openAction,
                  icon: const Icon(
                    Icons.format_quote_outlined,
                  ),
                );
              },
              openBuilder: (BuildContext context, VoidCallback openAction) {
                return ComposeStatusWidget(
                    quotedStatus: widget.status.reblog ?? widget.status);
              },
              closedElevation: 0,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Share.share(widget.status.uri!);
              },
              icon: const Icon(
                Icons.share_outlined,
              ),
            ),
          ],
        ),
        // todo implement additional actions
        // const Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Icon(
        //       Icons.more_vert_rounded,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
