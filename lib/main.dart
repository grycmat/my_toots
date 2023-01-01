import 'package:flex_color_scheme/flex_color_scheme.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Comfortaa',
        brightness: watchOnly<ThemeService, Brightness>(
            (ThemeService service) =>
                service.isDark ? Brightness.dark : Brightness.light),
        primarySwatch: watchOnly<ThemeService, MaterialColor>(
            (ThemeService service) => service.primarySwatch),
      ),
      // theme: FlexThemeData.light(
      //   scheme: FlexScheme.aquaBlue,
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 9,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 10,
      //     blendOnColors: false,
      //     useFlutterDefaults: true,
      //     bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      //     bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
      //     bottomNavigationBarShowUnselectedLabels: false,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: true,
      //   swapLegacyOnMaterial3: true,
      //   fontFamily: 'Comfortaa',
      // ),
      // darkTheme: FlexThemeData.dark(
      //   scheme: FlexScheme.aquaBlue,
      //   surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      //   blendLevel: 15,
      //   subThemesData: const FlexSubThemesData(
      //     blendOnLevel: 20,
      //     useFlutterDefaults: true,
      //     bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      //     bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
      //     bottomNavigationBarShowUnselectedLabels: false,
      //   ),
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      //   useMaterial3: true,
      //   swapLegacyOnMaterial3: true,
      //   fontFamily: 'Comfortaa',
      // ),
      // themeMode: watchOnly((ThemeService s) => s.isDark)
      //     ? ThemeMode.dark
      //     : ThemeMode.light,
      home: _service.hasUserCredentials()
          ? HomePage()
          : const SelectInstancePage(),
    );
  }
}
