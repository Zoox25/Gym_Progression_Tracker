import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/excercise.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:hive/hive.dart';

class ExcercisesSelectionViewmodel extends ChangeNotifier {
  ExerciseRepository exerciseRepository;
  late final StreamSubscription subscription;

  ExcercisesSelectionViewmodel({required this.exerciseRepository});

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

  List<String> getExcerciseIDs() {
    List<String> excerciseIDs = [];

    for (var excercise in exerciseRepository.getAll()) {
      excerciseIDs.add(excercise.id);
    }

    return excerciseIDs;
  }

  

  String getExcerciseNameByID(String excerciseID) {

    for (var excercise in exerciseRepository.getAll()) {
      if (excerciseID == excercise.id) {
        return excercise.name;
      }
    }

    return "";
  }

}