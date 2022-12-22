import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
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
  int _chars = 0;
  File? _media;
  final List<String> _mediaIds = [];
  @override
  void initState() {
    _textEditingController.addListener(() {
      setState(() {
        _chars = _textEditingController.text.length;
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
    if (_textEditingController.text.isEmpty) {
      return;
    }
    final statusText = _textEditingController.text;
    final statusPayload =
        StatusPayload(status: statusText, mediaIds: _mediaIds);

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
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              8, 8, 8, MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (widget.inReplyToStatus == null
                    ? Container()
                    : StatusWidget(status: widget.inReplyToStatus!)),
                TextField(
                  autofocus: true,
                  controller: _textEditingController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        _postStatus(context);
                      },
                      icon: const Icon(Icons.send_outlined, size: 30),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: "Let's make some toots!",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _chars.toString(),
                    ),
                    IconButton(
                      onPressed: () {
                        FilePicker.platform
                            .pickFiles()
                            .then((FilePickerResult? result) {
                          if (result != null) {
                            File file = File(result.files.single.path!);
                            print(file);
                            getIt
                                .get<ApiService>()
                                .uploadFile(file)
                                .then((response) {
                              setState(() {
                                _media = file;
                                print(response.data);
                                _mediaIds.add(response.data['id']);
                              });
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Uploading media aborted'),
                              ),
                            );
                            // User canceled the picker
                          }
                        });
                      },
                      icon: Icon(Icons.add_photo_alternate_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.poll_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                _media != null ? Image.file(_media!) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
