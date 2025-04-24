import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dbState = context.read<DashboardBloc>().state;
    return BlocProvider(
      create: (_) => DashboardBloc(repository: context.read())
        ..add(FetchMetalChartData(
          metal: dbState.metalType,
          timeRange: dbState.selectedRange,
        )),
      child: Scaffold(
        appBar: AppBar(title: const Text("Gold-Silver Chart")),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (!state.isLoading && (state.errorMessage == null || state.errorMessage!.isEmpty)) {
              // return ListView.builder(
              //   itemCount: state.prices.length,
              //   itemBuilder: (context, index) {
              //     final price = state.prices[index];
              //     return ListTile(
              //       title: Text(price.date.toIso8601String()),
              //       trailing: Text(price.close.toStringAsFixed(2)),
              //     );
              //   },
              // );
              return Text(state.data.toString());
            } else if (state.errorMessage != null) {
              return Center(child: Text("Error: ${state.errorMessage}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
