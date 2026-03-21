import 'package:flutter/material.dart';
import 'package:gym_progression_tracker/locator/locator.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:gym_progression_tracker/view/excercise_chart_view.dart';
import 'package:gym_progression_tracker/viewmodel/excercise_chart_viewmodel.dart';
import 'package:gym_progression_tracker/viewmodel/excercises_selection_viewmodel.dart';

class ExcerciseSelectionView extends StatefulWidget {
  final ExcercisesSelectionViewmodel viewmodel;

  const ExcerciseSelectionView({super.key, required this.viewmodel});

  @override
  State<ExcerciseSelectionView> createState() => _ExcerciseSelectionViewState();
}

class _ExcerciseSelectionViewState extends State<ExcerciseSelectionView> {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewmodel,
      builder: (context, _) {
        return ListView.builder(
          itemCount: widget.viewmodel.getExcerciseNames().length,
          itemBuilder: (BuildContext context, int index) {
            String excerciseName = widget.viewmodel.getExcerciseNames()[index];
        
            return GestureDetector(
              onTap: () {
                ExcerciseChartViewmodel newViewmodel = ExcerciseChartViewmodel(exerciseName: excerciseName, exerciseRepository: locator.get<ExerciseRepository>())..init();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExcerciseChartView(viewmodel: newViewmodel)),
                );
              },
              child: Center(child: Text(excerciseName, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),),),
            );
          },
        );
      }
    );
  }

}
