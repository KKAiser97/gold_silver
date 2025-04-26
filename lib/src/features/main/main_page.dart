import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/features/alert/alert_page.dart';
import 'package:gold_silver/src/features/dashboard/dashboard_page.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/news/news_page.dart';
import 'package:gold_silver/src/features/settings/settings_page.dart';
import 'package:gold_silver/src/theme/app_color.dart';
import 'package:gold_silver/src/utils/enums.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    BlocProvider<DashboardBloc>(
      create: (_) => locator<DashboardBloc>()
        ..add(const FetchMetalChartData(
          metal: MetalType.gold,
          timeRange: TimeRange.oneYear,
        )),
      child: const DashboardPage(),
    ),
    const AlertsPage(),
    const NewsPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gold Silver Tracker'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.brandColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
