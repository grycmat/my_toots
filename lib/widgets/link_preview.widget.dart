import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as Dom;

class LinkPreviewWidget extends StatelessWidget {
  const LinkPreviewWidget({required this.element, Key? key}) : super(key: key);
  final Dom.Element element;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: AnyLinkPreview(
        displayDirection: UIDirection.uiDirectionHorizontal,
        bodyStyle: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
        ),
        titleStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        errorWidget: const SizedBox(),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        removeElevation: true,
        link: element.attributes['href']!,
      ),
    );
  }
}
