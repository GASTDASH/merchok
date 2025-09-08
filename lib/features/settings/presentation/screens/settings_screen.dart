import 'package:flutter/material.dart';
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
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'Экспорт данных',
                  subtitle:
                      'Экспортировать данные для переноса на другое устройство',
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'Способы оплаты',
                  subtitle: 'Настроить способы оплаты для ваших покупателей',
                ),
                SettingsButton(
                  onTap: () {},
                  title: '(Политика)',
                  subtitle: '(Политика)',
                ),
                SettingsButton(
                  onTap: () {},
                  title: 'О приложении',
                  subtitle: 'Информация о приложении',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
