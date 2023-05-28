import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_toots/pages/web_login.page.dart';

class SelectInstancePage extends StatefulWidget {
  const SelectInstancePage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<SelectInstancePage> createState() => _SelectInstancePageState();
}

class _SelectInstancePageState extends State<SelectInstancePage> {
  late final TextEditingController _controller;
  final bool _isSearching = false;

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
                ).animate().fadeIn().slide(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCirc,
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
                ).animate().fadeIn().slide(
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 100),
                      curve: Curves.easeOutCirc,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WebLoginPage(_controller.text),
                      ),
                    );
                  },
                  child: const Text('Log in selected instance'),
                ).animate().fadeIn().slide(
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCirc,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WebLoginPage('101010.pl'),
                      ),
                    );
                  },
                  child: const Text('Or try 101010.pl!'),
                ).animate().fadeIn().slide(
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCirc,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
