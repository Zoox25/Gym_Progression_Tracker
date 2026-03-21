import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/viewmodel/excercise_chart_viewmodel.dart';
import 'package:intl/intl.dart';

class ExcerciseChartView extends StatefulWidget {
  final ExcerciseChartViewmodel viewmodel;
  const ExcerciseChartView({super.key, required this.viewmodel});

  @override
  State<ExcerciseChartView> createState() => _ExcerciseChartViewState();
}

class _ExcerciseChartViewState extends State<ExcerciseChartView> {

  List<FlSpot> generateWeightSpots(List<Record_> records) {
    List<FlSpot> spots = [];
    int currentIndex = 0;

    for (Record_ record in sortRecords(records)) {
      spots.add(FlSpot(currentIndex.toDouble(), record.weight));
      currentIndex++;
    }
    return spots;
  }

  List<FlSpot> generateRepsSpots(List<Record_> records) {
    List<FlSpot> spots = [];
    int currentIndex = 0;

    for (Record_ record in sortRecords(records)) {
      spots.add(FlSpot(currentIndex.toDouble(), record.reps.toDouble()));
      currentIndex++;
    }
    return spots;
  }

  List<Record_> sortRecords(List<Record_> records) {
    records.sort((a, b) => a.date.compareTo(b.date));
    return records;
  }

  double calcHighestY() {
    List<Record_> records = widget.viewmodel.getRecords();
    double highestY = 0;

    for (var record in records) {
      if (record.weight > highestY) {
        highestY = record.weight;
      }
      if (record.reps > highestY) {
        highestY = record.reps.toDouble();
      }
    }

    return highestY;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.viewmodel.getExcerciseName()),
      ),
      body: AnimatedBuilder(
        animation: widget.viewmodel,
        builder: (context, _) {
          List<Record_> localRecords = sortRecords(List.from(widget.viewmodel.getRecords()));

          List<FlSpot> weightSpots = generateWeightSpots(localRecords);
          List<FlSpot> repsSpots = generateRepsSpots(localRecords);
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LineChart(
              LineChartData(
                maxX: ((localRecords.length - 1) * 1.05).floor().toDouble(),
                maxY: (calcHighestY() * 1.05),
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
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (meta.axisSide != AxisSide.bottom) {
                          return const SizedBox();
                        }
            
                        int index = value.toInt();
                        if (index < 0 || index >= localRecords.length) return const SizedBox();
            
                        const maxLabels = 5;
                        final step = (localRecords.length / maxLabels).ceil();
            
                        final isStepFromEnd = (localRecords.length - index - 1) % step == 0;
            
                        if (isStepFromEnd) {
                          final record = localRecords[index];
                          return Text(DateFormat("yyyy-MM-dd").format(record.date));
                        }
            
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: weightSpots,
                    color: Color.fromRGBO(200, 20, 20, 1)
                    
                  ),
                  LineChartBarData(
                    spots: repsSpots,
                    color: Color.fromRGBO(20, 20, 200, 1)
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}