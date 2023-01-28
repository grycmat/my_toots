import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/models/status/status_payload.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/posting_status_alert.widget.dart';
import 'package:my_toots/widgets/status.widget.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

class ComposeStatusWidget extends StatefulWidget {
  const ComposeStatusWidget({this.inReplyToStatus, Key? key}) : super(key: key);
  final Status? inReplyToStatus;
  @override
  State<ComposeStatusWidget> createState() => _ComposeStatusWidgetState();
}

class _ComposeStatusWidgetState extends State<ComposeStatusWidget> {
  late final RichTextController _textEditingController;
  final _focusNode = FocusNode();
  int _chars = 0;
  List<File> _mediaFiles = [];
  String preSelectionString = '';
  final List<String> _mediaIds = [];
  final Map<String, String> _mentions = {};

  @override
  void initState() {
    final mentionStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.blue.shade200,
    );
    _textEditingController = RichTextController(
      onMatch: (match) {},
      patternMatchMap: {
        RegExp(r"\B@[@a-zA-Z0-9\.]+\b"): mentionStyle,
        RegExp(r"\B#[a-zA-Z0-9]+\b"): mentionStyle,
      },
    );

    if (widget.inReplyToStatus != null) {
      _textEditingController.text = '@${widget.inReplyToStatus!.account.acct} ';
      _mentions[widget.inReplyToStatus!.account.id] =
          widget.inReplyToStatus!.account.acct;
    }

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

  Future<void> _postStatus() async {
    final service = getIt.get<ApiService>();
    final statusText = _textEditingController.text;
    final uploadedMedia = await service.uploadFiles(_mediaFiles);
    final uploadedMediaIds = uploadedMedia
        .map((response) => response.data!['id'] as String)
        .toList();
    final statusPayload =
        StatusPayload(status: statusText, mediaIds: uploadedMediaIds);

    if (widget.inReplyToStatus != null) {
      statusPayload.inReplyToId = widget.inReplyToStatus!.id;
    }

    return await getIt
        .get<ApiService>()
        .postStatus(statusPayload)
        .then((value) {
      Navigator.of(context).pop();
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    final service = getIt.get<ApiService>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      color: Theme.of(context).colorScheme.surface,
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
              RawAutocomplete<Account>(
                displayStringForOption: (option) => option.acct,
                textEditingController: _textEditingController,
                focusNode: _focusNode,
                optionsViewBuilder: (context, onSelected, options) => Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      height: 200.0,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);
                          return InkWell(
                            onTap: () {
                              final splitted =
                                  _textEditingController.text.split(' ');
                              splitted.removeAt(splitted.length - 1);
                              final nextText = splitted.join(' ');
                              _textEditingController.text =
                                  '$nextText @${option.acct} ';
                              _mentions[option.id] = option.acct;
                              _textEditingController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset:
                                          _textEditingController.text.length));
                            },
                            child: ListTile(
                              title: Text(option.acct),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 1,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
                optionsBuilder: ((textEditingValue) async {
                  final splitted = textEditingValue.text.split(' ');
                  final lastWord = splitted.last;
                  if (lastWord.length > 2 && lastWord.startsWith('@')) {
                    final accounts = await service.search(
                        lastWord.replaceFirst('@', ''), 'accounts');
                    return accounts as Iterable<Account>;
                  }
                  return const Iterable<Account>.empty();
                }),
                fieldViewBuilder: (context, textEditingController, focusNode,
                        onFieldSubmitted) =>
                    TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  focusNode: focusNode,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () async {
                        if (textEditingController.text.isEmpty) {
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const PostingStatusAlertWidget(),
                        );
                        await _postStatus().then(
                          (_) => Navigator.of(context).pop(),
                        );
                      },
                      icon: const Icon(Icons.send_outlined, size: 30),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: "Let's toot something!",
                  ),
                ),
              ),
              _mediaFiles.isEmpty
                  ? const SizedBox()
                  : GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      children: _mediaFiles
                          .map(
                            (File f) => Stack(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(f, fit: BoxFit.cover),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                          )
                          .toList(),
                    ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _chars.toString(),
                    ),
                    IconButton(
                      onPressed: () {
                        FilePicker.platform
                            .pickFiles(allowMultiple: true)
                            .then((FilePickerResult? result) {
                          if (result != null) {
                            final List<PlatformFile> selectedFiles =
                                result.files;
                            if (selectedFiles.isEmpty) {
                              return;
                            }
                            final List<File> files = selectedFiles
                                .map((f) => File(f.path!))
                                .toList();
                            setState(() {
                              _mediaFiles = files;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Uploading media aborted'),
                              ),
                            );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
