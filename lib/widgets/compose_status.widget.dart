import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/models/status/status_payload.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status.widget.dart';

class ComposeStatusWidget extends StatefulWidget {
  const ComposeStatusWidget({this.inReplyToStatus, Key? key}) : super(key: key);
  final Status? inReplyToStatus;
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

    if (widget.inReplyToStatus != null) {
      statusPayload.inReplyToId = widget.inReplyToStatus!.id;
    }

    getIt.get<ApiService>().postStatus(statusPayload).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              (widget.inReplyToStatus == null
                  ? Container()
                  : StatusWidget(status: widget.inReplyToStatus!)),
              TextField(
                autofocus: true,
                controller: _textEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Let's make some toots!",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    chars.toString(),
                  ),
                  IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _postStatus(context);
                    },
                    icon: const Icon(Icons.send_outlined, size: 30),
                  ),
                  IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        print(file);
                        getIt.get<ApiService>().uploadFile(file).then((value) {
                          print(value);
                        });
                      } else {
                        print('user cancelled picker');
                        // User canceled the picker
                      }
                    },
                    icon: const Icon(Icons.add_photo_alternate_outlined,
                        size: 30),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
