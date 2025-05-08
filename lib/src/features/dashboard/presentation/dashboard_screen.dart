import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gold_silver/src/theme/theme.dart';
import 'package:gold_silver/src/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
                Text('select'.i18n()),
                const SizedBox(width: 16),
                DropdownButton<MetalType>(
                  value: context.watch<DashboardBloc>().state.metalType,
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
          Wrap(
              children: context.watch<DashboardBloc>().timeRanges.map((timeRange) {
            return ValueListenableBuilder<bool>(
              valueListenable: timeRange.isSelected,
              builder: (BuildContext context, bool value, Widget? child) {
                return InkWell(
                  onTap: () => context.read<DashboardBloc>().add(TimeRangeSelected(timeRange.timeRange)),
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: value ? AppColors.schemeColor : AppColors.transparent,
                          border: Border.all(color: AppColors.black),
                          borderRadius: const BorderRadius.all(Radius.circular(6))),
                      child: Text(timeRange.timeRange.val)),
                );
              },
            );
          }).toList()),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (!state.isLoading && (state.errorMessage == null || state.errorMessage!.isEmpty)) {
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    width: double.infinity,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.schemeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6), // Reduced border radius
                            ),
                          ),
                          onPressed: () {
                            context.read<DashboardBloc>().add(FetchCurrentPrice(state.metalType));
                          },
                          child: Text('update_price'.i18n()),
                        ),
                        DropdownButton<MetalUnit>(
                          value: context.watch<DashboardBloc>().state.metalUnit,
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
                  ),
                  const SizedBox(height: 16),
                  Text(
                      '${'current_price_world'.i18n()}: ${state.metalUnit == MetalUnit.ounce ? state.currentPrice : state.currentPriceConvertToTael} ${state.metalUnit == MetalUnit.ounce ? 'USD/oz' : 'VND/lượng'}'),
                  const SizedBox(height: 16),
                  if (state.currentDojiPrice != null && state.metalType == MetalType.gold)
                    Text('${'current_price_vn'.i18n()}: ${state.currentDojiPrice?.toStringAsFixed(0)} VND/lượng'),
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
