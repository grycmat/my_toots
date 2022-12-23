import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as Dom;

class LinkPreviewWidget extends StatelessWidget {
  const LinkPreviewWidget({required this.element, Key? key}) : super(key: key);
  final Dom.Element element;

  @override
  Widget build(BuildContext context) {
    return AnyLinkPreview(
      displayDirection: UIDirection.uiDirectionVertical,
      bodyStyle: Theme.of(context).textTheme.titleSmall,
      titleStyle: Theme.of(context).textTheme.titleLarge,
      errorWidget: const SizedBox(),
      backgroundColor: Theme.of(context).cardTheme.color,
      removeElevation: true,
      link: element.attributes['href']!,
    );
  }
}
