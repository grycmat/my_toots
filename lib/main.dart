import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:injectable/injectable.dart';
import 'package:my_toots/color_schemes.dart';
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
  runApp(MyToots());
}

class MyToots extends StatelessWidget with GetItMixin {
  MyToots({super.key});
  final _service = getIt.get<ApiService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: 'Comfortaa',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: 'Comfortaa',
      ),
      themeMode: watchOnly<ThemeService, ThemeMode>((ThemeService service) =>
          service.isDark ? ThemeMode.dark : ThemeMode.light),
      home: _service.hasUserCredentials()
          ? HomePage()
          : const SelectInstancePage(),
    );
  }
}
