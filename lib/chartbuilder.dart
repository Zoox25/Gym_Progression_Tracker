import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:intl/intl.dart';

class ChartBuilder {

  List<Record_> myRecords = [];

  void addDataSet(Record_ record) {
    myRecords.add(record);
    sortRecords();
  }

  void sortRecords() {
    myRecords.sort((a, b) => a.date.compareTo(b.date));
  }

  List<FlSpot> generateSpots() {
    sortRecords();
    List<FlSpot> spots = [];
    int currentIndex = 0;
    for (Record_ record in myRecords) {
      spots.add(FlSpot(currentIndex.toDouble(), record.weight));
      currentIndex++;
    }
    return spots;
  }

  Widget build() {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: generateSpots(),
          )
        ],
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = 0;
                for (Record_ record in myRecords) {
                  if (value.toStringAsFixed(3) == index.toStringAsFixed(3)) {
                    return Text(DateFormat("yyyy-MM-dd").format(record.date));
                  }
                  index++;
                }
                return Text("");
              },
            ),
          ),
        ),
      ),
    );
  }
}