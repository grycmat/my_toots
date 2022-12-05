import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/main.config.dart';
import 'package:my_toots/pages/login.page.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => init(getIt);

Future<void> main() async {
  configureDependencies();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Outfit',
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
