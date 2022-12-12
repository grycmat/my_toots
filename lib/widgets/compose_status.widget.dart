import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status_payload.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/services/api.service.dart';

class ComposeStatusWidget extends StatefulWidget {
  const ComposeStatusWidget({Key? key}) : super(key: key);

  @override
  State<ComposeStatusWidget> createState() => _ComposeStatusWidgetState();
}

class _ComposeStatusWidgetState extends State<ComposeStatusWidget> {
  final _textEditingController = TextEditingController();
  int chars = 0;
  @override
  void initState() {
    _textEditingController.addListener(() {
      setState(() {
        chars = _textEditingController.text.length;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _postStatus(BuildContext context) {
    final statusText = _textEditingController.text;
    final statusPayload = StatusPayload(status: statusText);
    getIt.get<ApiService>().postStatus(statusPayload).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewInsets.bottom + 160,
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: _textEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Lets toot something!',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(chars.toString()),
                  IconButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _postStatus(context);
                      },
                      icon: const Icon(Icons.send_outlined, size: 30))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
