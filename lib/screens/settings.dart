import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Возвращаемся на предыдущий экран
          },
        ),
      ),
      body: SettingsList(), // Отображаем список настроек
    );
  }
}

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Dark Mode'), // Название настройки
          trailing: Switch(
            value: false, // Заглушка, можно использовать реальное значение из настроек приложения
            onChanged: (bool value) {
              // Действие при изменении значения переключателя
              // Можно добавить код для изменения режима темы приложения
            },
          ),
        ),
        ListTile(
          title: Text('Notifications'), // Название настройки
          trailing: Switch(
            value: false, // Заглушка, можно использовать реальное значение из настроек приложения
            onChanged: (bool value) {
              // Действие при изменении значения переключателя
              // Можно добавить код для включения/отключения напоминаний
            },
          ),
        ),
        // Добавьте другие настройки по аналогии
      ],
    );
  }
}
