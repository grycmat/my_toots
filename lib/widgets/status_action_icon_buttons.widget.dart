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
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 8, 4, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
                  child: IconButton(
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: Text(
                    widget.status.repliesCount.toString(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
                  child: IconButton(
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 8, 0),
                  child: Text(
                    widget.status.favouritesCount.toString(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: IconButton(
                    onPressed: () {
                      final service = getIt.get<ApiService>();
                      setState(() {
                        _isReblogged = !_isReblogged;
                      });
                      service.toggleReblog(
                          status: widget.status, reblog: _isReblogged);
                    },
                    icon: Icon(
                      Icons.loop_outlined,
                      color: _isReblogged ? Colors.green : Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 8, 0),
                  child: Text(
                    widget.status.reblogsCount.toString(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Icon(
                    Icons.share_outlined,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
