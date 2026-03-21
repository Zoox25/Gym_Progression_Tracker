import 'package:flutter/material.dart';
import 'package:gym_progression_tracker/locator/locator.dart';
import 'package:gym_progression_tracker/observer/action_button_observer.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:gym_progression_tracker/repository/record_repository.dart';
import 'package:gym_progression_tracker/view/excercise_creation_view.dart';
import 'package:gym_progression_tracker/view/record_menu_view.dart';
import 'package:gym_progression_tracker/viewmodel/excercise_creation_viewmodel.dart';
import 'package:gym_progression_tracker/viewmodel/excercise_menu_viewmodel.dart';
import 'package:gym_progression_tracker/viewmodel/record_menu_viewmodel.dart';

class ExcerciseMenuView extends StatefulWidget {
  final ExcerciseMenuViewmodel viewmodel;

  const ExcerciseMenuView({super.key, required this.viewmodel});

  @override
  State<ExcerciseMenuView> createState() => _ExcerciseMenuViewState();
}

class _ExcerciseMenuViewState extends State<ExcerciseMenuView> implements ActionButtonObserver {

  Map<String, String> excerciseWeights = {};
  Map<String, String> excerciseReps = {};
  
  @override
  void initState() {
    super.initState();
    widget.viewmodel.addActionButtonObserver(this);
  }

  @override
  void dispose() {
    widget.viewmodel.removeActionButtonObserver(this);

    super.dispose();
  }

  void initliazeInputMaps() {
    for (String excerciseName in widget.viewmodel.getExcerciseNames()) {
      if (!excerciseWeights.containsKey(excerciseName)) {
        excerciseWeights[excerciseName] = "0";
      }
      if (!excerciseReps.containsKey(excerciseName)) {
        excerciseReps[excerciseName] = "0";
      }
    }
  }

  @override
  void onActionButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ExcerciseCreationView(viewmodel: ExcerciseCreationViewmodel(exerciseRepository: locator.get<ExerciseRepository>())..init())));
  }

  void addRecord(String excerciseName) {
    String weight = excerciseWeights[excerciseName]!;
    String reps = excerciseReps[excerciseName]!;
    widget.viewmodel.addRecord(excerciseName, weight, reps);
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: widget.viewmodel,
      builder: (context, _) {
        List<String> excerciseNames = widget.viewmodel.getExcerciseNames();
        initliazeInputMaps();
        return ListView.builder(
          itemCount: excerciseNames.length,
          itemBuilder: (BuildContext context, int index) {
            String excerciseName = excerciseNames[index];
            return Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RecordMenuView(viewmodel: RecordMenuViewmodel(exerciseName: excerciseName, exerciseRepository: locator.get<ExerciseRepository>(), recordRepository: locator.get<RecordRepository>())..init())));
                    },
                    child: Text(excerciseName)
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Weight",
                      ),
                      onChanged: (value) {
                        excerciseWeights[excerciseName] = value;
                      }
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Reps",
                      ),
                      onChanged: (value) {
                        excerciseReps[excerciseName] = value;
                      }
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      addRecord(excerciseName);
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            );
          },
        );
      }
    );

  }
}
