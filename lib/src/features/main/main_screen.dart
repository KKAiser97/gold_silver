import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/injector/locator.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_bloc.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_event.dart';
import 'package:gold_silver/src/features/news/presentation/news_screen.dart';
import 'package:gold_silver/src/features/settings/settings_screen.dart';
import 'package:gold_silver/src/theme/app_color.dart';
import 'package:gold_silver/src/utils/enums.dart';
import 'package:localization/localization.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    BlocProvider<DashboardBloc>(
      create: (_) => locator<DashboardBloc>()
        ..add(const FetchMetalChartData(
          metal: MetalType.gold,
          timeRange: TimeRange.oneYear,
        )),
      child: const DashboardScreen(),
    ),
    BlocProvider<NewsBloc>(
      create: (context) => locator<NewsBloc>()..add(NewsEvent(context)),
      child: const NewsScreen(),
    ),
    const SettingsScreen(),
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
        title: Text('app_name'.i18n()),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.brandColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.show_chart),
            label: 'dashboard'.i18n(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article),
            label: 'news'.i18n(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'settings'.i18n(),
          ),
        ],
      ),
    );
  }
}
