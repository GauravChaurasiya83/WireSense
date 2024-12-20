import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealTimeChartExample extends StatefulWidget {
  const RealTimeChartExample({super.key});

  @override
  State<RealTimeChartExample> createState() => _RealTimeChartExampleState();
}

class _RealTimeChartExampleState extends State<RealTimeChartExample> {
  // Data source which binds to the series
  List<_ChartData> chartData = [];
  Timer? timer;

  // Random instance
  final Random random = Random();

  // Redraw the series with updating or creating new points by using this controller.
  ChartSeriesController? _chartSeriesController;

  // Count of type integer which binds as x value for the series
  int count = 19;

  @override
  void initState() {
    super.initState();
    chartData = [
      _ChartData(0, 42),
      _ChartData(1, 47),
      _ChartData(2, 33),
      _ChartData(3, 49),
      _ChartData(4, 54),
      _ChartData(5, 41),
      _ChartData(6, 58),
      _ChartData(7, 51),
      _ChartData(8, 98),
      _ChartData(9, 41),
      _ChartData(10, 53),
      _ChartData(11, 72),
      _ChartData(12, 86),
      _ChartData(13, 52),
      _ChartData(14, 94),
      _ChartData(15, 92),
      _ChartData(16, 86),
      _ChartData(17, 72),
      _ChartData(18, 94),
    ];
    // Start the timer in initState
    timer = Timer.periodic(const Duration(seconds: 1), _updateDataSource);
  }

  void _updateDataSource(Timer timer) {
    chartData.add(_ChartData(count, random.nextInt(90) + 10));
    if (chartData.length == 20) {
      // Removes the last index data of data source.
      chartData.removeAt(0);
      // Update the chart data source
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: [(chartData.length) - 1],
        removedDataIndexes: [0],
      );
    }
    count += 1;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
          series: <LineSeries<_ChartData, int>>[
            LineSeries<_ChartData, int>(
              onRendererCreated: (ChartSeriesController controller) {
                // Assigning the controller to the _chartSeriesController.
                _chartSeriesController = controller;
              },
              // Binding the chartData to the dataSource of the line series.
              dataSource: chartData,
              xValueMapper: (_ChartData sales, _) => sales.year,
              yValueMapper: (_ChartData sales, _) => sales.sales,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.year, this.sales);

  final int year;
  final int sales;
}
