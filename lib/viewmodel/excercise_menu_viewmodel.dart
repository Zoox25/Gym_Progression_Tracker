import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/excercise.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/observer/action_button_observer.dart';
import 'package:gym_progression_tracker/observer/action_button_subject.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:gym_progression_tracker/repository/record_repository.dart';
import 'package:hive_flutter/adapters.dart';

class ExcerciseMenuViewmodel extends ChangeNotifier implements ActionButtonSubject {
  ExerciseRepository exerciseRepository;
  RecordRepository recordRepository;
  List<ActionButtonObserver> actionButtonObserver = [];
  
  late final StreamSubscription subscription;

  ExcerciseMenuViewmodel({required this.exerciseRepository, required this.recordRepository});

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

  List<String> getExcerciseNames() {
    List<String> excerciseNames = [];

    for (var excercise in exerciseRepository.getAll()) {
      excerciseNames.add(excercise.name);
    }

    return excerciseNames;
  }

  bool addRecord(String excerciseName, String weight, String reps) {
    double weight_;
    int reps_;

    try {
      weight_ = double.parse(weight);
    } on FormatException catch (_) {
      return false;
    }

    try {
      reps_ = int.parse(reps);
    } on FormatException catch (_) {
      return false;
    }

    DateTime date = DateTime.now();
    recordRepository.addRecord(excerciseName, Record_(weight: weight_, reps: reps_, date: date));
    return true;
  }

  bool addExcercise(String name, String description) {
    exerciseRepository.addExercise(Excercise(name: name, description: description, records: []));
    return true;
  }

  @override
  void onFloatingActionButton() {
    for (ActionButtonObserver observer in actionButtonObserver) {
      observer.onActionButton();
    }
  }

  @override
  void addActionButtonObserver(ActionButtonObserver observer) {
    actionButtonObserver.add(observer);
  }

  @override
  void removeActionButtonObserver(ActionButtonObserver observer) {
    actionButtonObserver.remove(observer);
  }

}