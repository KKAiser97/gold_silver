import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cài đặt cảnh báo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Tỷ lệ thấp nhất để mua vàng',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Tỷ lệ cao nhất để mua bạc',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text('Gửi cảnh báo qua Gmail'),
          ),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            title: const Text('Gửi cảnh báo qua Telegram'),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            'Tùy chọn nâng cao',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf_outlined),
            title: const Text('Gửi báo cáo hằng tuần (PDF, Excel)'),
            subtitle: const Text('Tự động gửi vào mỗi cuối tuần'),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          ListTile(
            leading: const Icon(Icons.show_chart_outlined),
            title: const Text('Đính kèm biểu đồ trực tiếp trong cảnh báo Telegram'),
            subtitle: const Text('Hiển thị biểu đồ giá vàng/bạc theo thời gian thực'),
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
        ],
      ),
    );
  }
}