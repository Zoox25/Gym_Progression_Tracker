import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:hive_flutter/adapters.dart';

class ExcerciseChartViewmodel extends ChangeNotifier {
  String exerciseName;
  String exerciseID;
  ExerciseRepository exerciseRepository;

  late final StreamSubscription subscription;

  ExcerciseChartViewmodel({required this.exerciseID, required this.exerciseName, required this.exerciseRepository});
  void init() {
    subscription = Hive.box<User>('user').watch().listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  String getExcerciseName() {
    return exerciseName;
  }

  List<Record_> getRecords() {
    return exerciseRepository.getAllRecordsByExerciseID(exerciseID);
  }
}
