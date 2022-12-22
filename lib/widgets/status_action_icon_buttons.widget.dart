import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/services/widget.service.dart';

class StatusActionIconButtonsWidget extends StatelessWidget {
  const StatusActionIconButtonsWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

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
                            .getComposeWidget(inReplyToStatus: status),
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
                    status.repliesCount.toString(),
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
                      status.favourited
                          ? service.unfavouriteStatus(status)
                          : service.favouriteStatus(status);
                    },
                    icon: Icon(
                      Icons.favorite_border_rounded,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 8, 0),
                  child: Text(
                    status.favouritesCount.toString(),
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
                      status.reblogged
                          ? service.undoBoostStatus(status)
                          : service.boostStatus(status);
                    },
                    icon: Icon(
                      Icons.loop_outlined,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 8, 0),
                  child: Text(
                    status.reblogsCount.toString(),
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
