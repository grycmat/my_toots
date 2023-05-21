import 'package:flutter/material.dart';

class PostingStatusAlertWidget extends StatelessWidget {
  const PostingStatusAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
