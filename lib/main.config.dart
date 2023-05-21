// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import 'services/api.service.dart' as _i6;
import 'services/shared_prefs.service.dart' as _i7;
import 'services/theme.service.dart' as _i4;
import 'services/widget.service.dart' as _i5;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i3.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i4.ThemeService>(
      _i4.ThemeService.init(gh<_i3.SharedPreferences>()));
  gh.singleton<_i5.WidgetService>(_i5.WidgetService());
  gh.singleton<_i6.ApiService>(
      _i6.ApiService.init(gh<_i3.SharedPreferences>()));
  return getIt;
}

class _$RegisterModule extends _i7.RegisterModule {}
