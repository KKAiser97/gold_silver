import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ListTile(
          leading: Icon(Icons.article_outlined),
          title: Text('Giá vàng tăng mạnh do lo ngại lạm phát'),
          subtitle: Text('Cập nhật lúc 09:00, 22/04/2025'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.article_outlined),
          title: Text('Bạc tăng giá mạnh sau khi vượt kháng cự kỹ thuật'),
          subtitle: Text('Cập nhật lúc 10:30, 22/04/2025'),
        ),
      ],
    );
  }
}