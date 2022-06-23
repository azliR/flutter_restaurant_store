import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_restaurant_store/bloc/report/report_cubit.dart';
import 'package:flutter_restaurant_store/injection.dart';
import 'package:flutter_restaurant_store/models/item_trend.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportPage extends StatefulWidget with AutoRouteWrapper {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReportCubit>()..getReport(),
      child: this,
    );
  }

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ReportCubit>().getReport();
            },
          ),
        ],
      ),
      body:
          BlocSelector<ReportCubit, ReportState, Map<String, List<ItemTrend>>>(
        selector: (state) => state.report,
        builder: (context, report) {
          return SfCartesianChart(
            plotAreaBorderWidth: 1,
            title: ChartTitle(text: 'Trend penjualan items 2021-2022'),
            legend: Legend(
              isVisible: true,
            ),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0),
              labelFormat: '{value}',
              majorTickLines: const MajorTickLines(size: 0),
            ),
            series: report.entries.map((e) {
              return StackedBarSeries<ItemTrend, String>(
                dataSource: e.value.cast(),
                xValueMapper: (report, _) =>
                    DateFormat('MMM').format(report.date),
                yValueMapper: (report, _) =>
                    int.parse(report.totalSales.toString()),
                name: e.key,
              );
            }).toList(),
            tooltipBehavior: _tooltipBehavior,
          );
        },
      ),
    );
  }
}
