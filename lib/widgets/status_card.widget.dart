import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_toots/models/status/status.dart';

class StatusCardWidget extends StatelessWidget {
  Status status;
  StatusCardWidget({required this.status, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  status.account.avatarStatic,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 0, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status.account.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF101213),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            status.account.acct,
                            style: const TextStyle(
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 4, 12),
                child: status.reblog == null
                    ? Html(
                        data: status.content,
                        style: {'p': Style(fontSize: FontSize(8))},
                      )
                    : Center(
                        child: Card(
                          color: Colors.green[100],
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.repeat_outlined),
                                    ),
                                    Text(
                                      status.reblog!.account.acct,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Color(0xFF101213),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Html(
                                          data: status.reblog!.content,
                                          style: {
                                            'p': Style(fontSize: FontSize(8))
                                          }),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: status
                                            .reblog!.mediaAttachments.isNotEmpty
                                        ? Image.network(
                                            status.reblog!.mediaAttachments
                                                .first.previewUrl,
                                            width: double.infinity,
                                            height: 230,
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: status.mediaAttachments.isNotEmpty
                    ? Image.network(
                        status.mediaAttachments.first.previewUrl,
                        width: double.infinity,
                        height: 230,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 8, 4, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
                            child: Icon(
                              Icons.mode_comment_outlined,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 0, 8, 0),
                            child: Text(
                              status.repliesCount.toString(),
                              style: const TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
                            child: Icon(
                              Icons.favorite_border_rounded,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4, 0, 8, 0),
                            child: Text(
                              status.favouritesCount.toString(),
                              style: const TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.loop_outlined,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4, 0, 8, 0),
                            child: Text(
                              status.reblogsCount.toString(),
                              style: const TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Icon(
                              Icons.share_outlined,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}