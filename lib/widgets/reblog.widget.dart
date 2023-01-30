import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/widget.service.dart';
import 'package:my_toots/widgets/media/media_attachment.widget.dart';
import 'package:my_toots/widgets/status/status_html_text.widget.dart';

class ReblogWidget extends StatelessWidget {
  const ReblogWidget(
      {required this.status, required this.rebloggerAcct, Key? key})
      : super(key: key);
  final Status status;
  final String rebloggerAcct;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => showBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          context: context,
          builder: (context) =>
              getIt.get<WidgetService>().getDetailsSheet(context, status),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.loop_outlined),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      rebloggerAcct,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: StatusHtmlTextWidget(status: status)),
                ],
              ),
              status.mediaAttachments.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: MediaAttachmentWidget(
                        mediaAttachments: status.mediaAttachments,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
