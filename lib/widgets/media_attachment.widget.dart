import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/widgets/status_media_attachment_details.widget.dart';

class MediaAttachmentWidget extends StatelessWidget {
  const MediaAttachmentWidget({required this.mediaAttachments, Key? key})
      : super(key: key);
  final List<MediaAttachment> mediaAttachments;

  @override
  Widget build(BuildContext context) {
    if (mediaAttachments.isEmpty) return Container();

    if (mediaAttachments.length == 1) {
      return StatusMediaAttachmentDetailsWidget(
          mediaAttachment: mediaAttachments.first);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: <Widget>[
          for (var mediaAttachment in mediaAttachments)
            StatusMediaAttachmentDetailsWidget(mediaAttachment: mediaAttachment)
        ],
      ),
    );
  }
}
