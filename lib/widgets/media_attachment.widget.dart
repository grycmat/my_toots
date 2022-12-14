import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/widgets/status_media_attachment_details.widget.dart';

class MediaAttachmentWidget extends StatelessWidget {
  const MediaAttachmentWidget({required this.mediaAttachments, Key? key})
      : super(key: key);
  final List<MediaAttachment> mediaAttachments;

  @override
  Widget build(BuildContext context) {
    switch (mediaAttachments.length) {
      case 1:
        return StatusMediaAttachmentDetailsWidget(
            mediaAttachment: mediaAttachments.first);
      case 2:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (var mediaAttachment in mediaAttachments)
                StatusMediaAttachmentDetailsWidget(
                    mediaAttachment: mediaAttachment)
            ],
          ),
        );
      case 3:
      case 4:
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
                StatusMediaAttachmentDetailsWidget(
                    mediaAttachment: mediaAttachment)
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
