import 'package:flutter/material.dart';

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
                  hintText: 'Compose a toot...',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(chars.toString()),
                  IconButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      icon: Icon(Icons.send_outlined))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
