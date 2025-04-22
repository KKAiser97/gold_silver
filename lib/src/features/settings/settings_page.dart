import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.login),
          title: Text('Đăng nhập bằng Google'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Đổi mật khẩu'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications_active),
          title: Text('Cài đặt thông báo'),
        ),
      ],
    );
  }
}