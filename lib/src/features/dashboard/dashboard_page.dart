import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gold_silver/src/utils/enums.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Gold-Silver Chart")),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Select Metal"),
                const SizedBox(width: 16),
                DropdownButton<MetalType>(
                  // value: context.read<DashboardBloc>().state.metalType,
                  items: MetalType.values.map((MetalType metal) {
                    return DropdownMenuItem<MetalType>(
                      value: metal,
                      child: Text(metal.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<DashboardBloc>().add(MetalToggled(metalType: value));
                    }
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (!state.isLoading && (state.errorMessage == null || state.errorMessage!.isEmpty)) {
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    width: double.infinity,
                    // Ensures the container takes the full width
                    child: AspectRatio(
                      aspectRatio: 1.2,
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
                                interval: state.interval.value,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text('${((value ~/ state.interval.value) * state.interval.value).toInt()}');
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<DashboardBloc>().add(FetchCurrentPrice(state.metalType));
                        },
                        child: Text('Cập nhật giá'),
                      ),
                      DropdownButton<MetalUnit>(
                        // value: context.read<DashboardBloc>().state.metalType,
                        items: MetalUnit.values.map((MetalUnit metal) {
                          return DropdownMenuItem<MetalUnit>(
                            value: metal,
                            child: Text(metal.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<DashboardBloc>().add(UnitToggled(value));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                      'Giá hiện tai: ${state.metalUnit == MetalUnit.ounce ? state.currentPrice : state.currentPriceConvertToTael} ${state.metalUnit == MetalUnit.ounce ? 'USD/oz' : 'VND/lượng'}'),
                  const SizedBox(height: 16),
                  Text('Giá thực tế tại VN: '), //TODO: Add logic to get the real price in VN
                ]);
              } else if (state.errorMessage != null) {
                return Center(child: Text("Error: ${state.errorMessage}"));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      )),
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
