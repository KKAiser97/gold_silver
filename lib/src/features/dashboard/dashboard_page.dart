import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/core/client/locator.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gold_silver/src/utils/enums.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DashboardBloc>()
        ..add(const FetchMetalChartData(
          metal: MetalType.gold,
          timeRange: TimeRange.oneYear,
        )),
      child: Scaffold(
        appBar: AppBar(title: const Text("Gold-Silver Chart")),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (!state.isLoading && (state.errorMessage == null || state.errorMessage!.isEmpty)) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: LineChart(
                  LineChartData(
                    maxY: state.maxY.toDouble(),
                    lineTouchData: _customTouchData(),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        spots: state.chartSpots,
                        color: Colors.amber,
                        barWidth: 2,
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: state.interval,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text('${((value ~/ state.interval) * state.interval).toInt()}');
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (value, meta) {
                            // x-axis labels
                            return Text('${value.toInt()}');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state.errorMessage != null) {
              return Center(child: Text("Error: ${state.errorMessage}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  LineTouchData _customTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            final price = spot.y;
            final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(spot.x.toInt()));
            return LineTooltipItem(
              '$formattedDate\n\$ $price',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          }).toList();
        },
      ),
    );
  }
}
