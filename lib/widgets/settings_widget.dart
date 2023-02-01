import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:my_toots/services/theme.service.dart';

class SettingsWidget extends StatelessWidget with GetItMixin {
  SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.all(24),
            dense: false,
            title: Text('Dark mode',
                style: Theme.of(context).textTheme.titleLarge),
            value: get<ThemeService>().isDark,
            onChanged: (value) {
              get<ThemeService>().setIsDark(value);
            },
          )
        ],
      ),
    );
  }
}
