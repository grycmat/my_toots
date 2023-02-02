import 'package:flutter/material.dart';
import 'package:my_toots/pages/web_login.page.dart';

class SelectInstancePage extends StatefulWidget {
  const SelectInstancePage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<SelectInstancePage> createState() => _SelectInstancePageState();
}

class _SelectInstancePageState extends State<SelectInstancePage> {
  late final TextEditingController _controller;
  bool _isSearching = false;

  @override
  initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.verified_outlined,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    prefixText: 'https://',
                    border: OutlineInputBorder(),
                    labelText: 'Choose Instance',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WebLoginPage(_controller.text),
                      ),
                    );
                  },
                  child: const Text('Log in selected instance'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WebLoginPage('101010.pl'),
                      ),
                    );
                  },
                  child: const Text('Or try 101010.pl!'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
