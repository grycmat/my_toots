import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/pages/select_instance.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/services/theme.service.dart';

class SettingsWidget extends StatelessWidget with GetItMixin {
  SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SwitchListTile(
            title: Text('Dark mode',
                style: Theme.of(context).textTheme.titleLarge),
            value: get<ThemeService>().isDark,
            onChanged: (value) {
              get<ThemeService>().setIsDark(value);
            },
          ),
          ListTile(
            title:
                Text('Logout', style: Theme.of(context).textTheme.titleLarge),
            onTap: () {
              getIt.get<ApiService>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SelectInstancePage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
