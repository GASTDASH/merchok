import 'package:flutter/material.dart';
import 'package:merchok/core/core.dart';
import 'package:merchok/features/settings/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            sliver: SliverList.list(
              children: [
                SettingsButton(
                  onTap: () {},
                  title: 'Тема',
                  subtitle: 'Изменение темы приложения',
                  icon: IconNames.theme,
                  iconSize: 32,
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'Язык',
                  subtitle: 'Изменение региональных настроек',
                  icon: IconNames.language,
                  iconSize: 32,
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'Экспорт данных',
                  subtitle:
                      'Экспортировать данные для переноса на другое устройство',
                  icon: IconNames.downloadPackage,
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'Способы оплаты',
                  subtitle: 'Настроить способы оплаты для ваших покупателей',
                  icon: IconNames.payment,
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'О приложении',
                  subtitle: 'Информация о приложении',
                  icon: IconNames.info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
