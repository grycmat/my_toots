import 'package:flutter/material.dart';
import 'package:my_toots/widgets/compose/compose_status.widget.dart';

class ComposeStatusContainerWidget extends StatelessWidget {
  const ComposeStatusContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose'),
      ),
      body: const ComposeStatusWidget(),
    );
  }
}
