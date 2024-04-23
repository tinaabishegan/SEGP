import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StressLineChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  StressLineChart({required this.data, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime oneMonthAgo = currentDate.subtract(Duration(days: 30));

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.8,
            height: MediaQuery.sizeOf(context).height * 0.43,
            color: const Color.fromARGB(
              0,
              216,
              192,
              192,
            ), // Set container background color to transparent
            child: SfCartesianChart(
              title: ChartTitle(
                text: 'Stress Level in the Past Month',
                textStyle: TextStyle(fontSize: 12, color: Colors.white),
              ),
              plotAreaBackgroundColor: Colors
                  .transparent, // Set plot area background color to transparent
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('dd-MM'),
                minimum: oneMonthAgo,
                maximum: currentDate,
                interval: 4,
                labelStyle: TextStyle(color: Colors.white),
              ),
              primaryYAxis: const NumericAxis(
                minimum: 0,
                maximum: 4,
                interval: 1,
                majorTickLines: MajorTickLines(size: 0),
                labelStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.transparent,
                ), // Adjust fontSize here
                majorGridLines: MajorGridLines(
                  color: Colors.white, // Set grid line color
                ),
              ),
              series: <CartesianSeries<Map<String, dynamic>, DateTime>>[
                SplineSeries<Map<String, dynamic>, DateTime>(
                  dataSource: _generateChartData(),
                  xValueMapper: (Map<String, dynamic> item, _) =>
                      item['date_tested'] as DateTime,
                  yValueMapper: (Map<String, dynamic> item, _) =>
                      item['mean_stress_level'] as double,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: false,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  splineType: SplineType.monotonic,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    height: 10,
                    width: 10,
                    borderWidth: 2,
                    color: Colors.white,
                    borderColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
// Adjust the position as needed
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.1,
            height: MediaQuery.sizeOf(context).height * 0.1,
            decoration: BoxDecoration(
              color: Color.fromARGB(0, 0, 0, 0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'High',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Mid',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Low',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _generateChartData() {
    Map<String, List<double>> dateStressMap = {};

    for (int i = 0; i < data.length; i++) {
      DateTime date = DateTime.parse(data[i]['date_tested']);
      if (date.isAfter(DateTime.now().subtract(Duration(days: 30)))) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        double stressLevel = _mapStressLevel(data[i]['stress_level']);

        if (dateStressMap.containsKey(formattedDate)) {
          dateStressMap[formattedDate]!.add(stressLevel);
        } else {
          dateStressMap[formattedDate] = [stressLevel];
        }
      }
    }

    List<Map<String, dynamic>> chartData = [];
    dateStressMap.forEach((date, stressList) {
      double meanStress = _calculateMeanStress(stressList);
      chartData.add({
        'date_tested': DateTime.parse(date),
        'mean_stress_level': meanStress,
      });
    });

    print(chartData);

    return chartData;
  }

  double _mapStressLevel(String stressLevel) {
    switch (stressLevel.toLowerCase()) {
      case 'no stress':
        return 0.0;
      case 'low stress':
        return 1.0;
      case 'mid stress':
        return 2.0;
      case 'high stress':
        return 3.0;
      default:
        return 0.0;
    }
  }

  double _calculateMeanStress(List<double> stressList) {
    if (stressList.isEmpty) return 0.0;

    double mean = stressList.reduce((value, element) => value + element) /
        stressList.length;

    return mean.round().toDouble();
  }
}
