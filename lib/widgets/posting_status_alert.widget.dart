import 'package:flutter/material.dart';

class PostingStatusAlertWidget extends StatelessWidget {
  const PostingStatusAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('posting status'),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
