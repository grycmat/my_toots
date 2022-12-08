import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/main.config.dart';
import 'package:my_toots/pages/instances_list.page.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies() => init(getIt);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await dotenv.load(fileName: '.env');
  runApp(const MyToots());
}

class MyToots extends StatelessWidget {
  const MyToots({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const InstancesListPage(),
    );
  }
}
