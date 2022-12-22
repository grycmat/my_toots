import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/main.config.dart';
import 'package:my_toots/pages/home.page.dart';
import 'package:my_toots/pages/select_instance.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/services/theme.service.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies() => init(getIt);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  getIt.registerSingleton<ThemeService>(ThemeService());
  runApp(MyToots());
}

class MyToots extends StatelessWidget with GetItMixin {
  MyToots({super.key});
  final _service = getIt.get<ApiService>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        useMaterial3: true,
        primarySwatch: Colors.green,
        brightness: watchOnly((ThemeService s) => s.isDark)
            ? Brightness.dark
            : Brightness.light,
      ),
      home: _service.hasUserCredentials()
          ? HomePage()
          : const SelectInstancePage(),
    );
  }
}
