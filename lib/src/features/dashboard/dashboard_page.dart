import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   String selectedAsset = 'gold';
//   String selectedTime = '1d';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchChart();
//     _setupAutoRefresh();
//   }
//
//   void _fetchChart() {
//     context.read<DashboardBloc>().add(FetchChartDataEvent(asset: selectedAsset, range: selectedTime));
//   }
//
//   void _setupAutoRefresh() {
//     Future.doWhile(() async {
//       await Future.delayed(const Duration(minutes: 10));
//       _fetchChart();
//       return mounted;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               ToggleButtons(
//                 isSelected: [selectedAsset == 'gold', selectedAsset == 'silver'],
//                 onPressed: (index) {
//                   setState(() {
//                     selectedAsset = index == 0 ? 'gold' : 'silver';
//                     _fetchChart();
//                   });
//                 },
//                 children: const [
//                   Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Vàng')),
//                   Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Bạc')),
//                 ],
//               ),
//               const Spacer(),
//               DropdownButton<String>(
//                 value: selectedTime,
//                 items: const [
//                   DropdownMenuItem(value: '1d', child: Text('1D')),
//                   DropdownMenuItem(value: '1w', child: Text('1W')),
//                   DropdownMenuItem(value: '1m', child: Text('1M')),
//                   DropdownMenuItem(value: '1y', child: Text('1Y')),
//                   DropdownMenuItem(value: '5y', child: Text('5Y')),
//                 ],
//                 onChanged: (value) {
//                   if (value != null) {
//                     setState(() {
//                       selectedTime = value;
//                       _fetchChart();
//                     });
//                   }
//                 },
//               )
//             ],
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: BlocBuilder<DashboardBloc, DashboardState>(
//               builder: (context, state) {
//                 if (state is ChartLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is ChartLoadedState) {
//                   return LineChart(LineChartData(
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: state.chartData,
//                         isCurved: true,
//                         color: selectedAsset == 'gold' ? Colors.amber : Colors.grey,
//                         barWidth: 3,
//                       )
//                     ],
//                   ));
//                 } else if (state is ChartErrorState) {
//                   return Center(child: Text('Lỗi: ${state.message}'));
//                 } else {
//                   return const Center(child: Text('Không có dữ liệu'));
//                 }
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }