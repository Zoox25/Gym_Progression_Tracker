
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:gym_progression_tracker/repository/record_repository.dart';
import 'package:hive/hive.dart';

class RecordMenuViewmodel extends ChangeNotifier {
  String exerciseID;
  String exerciseName;
  ExerciseRepository exerciseRepository;
  RecordRepository recordRepository;
  late final StreamSubscription subscription;

  RecordMenuViewmodel({required this.exerciseRepository, required this.exerciseName, required this.recordRepository, required this.exerciseID});

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

  void deleteExercise() {
    exerciseRepository.deleteExerciseByID(exerciseID);
  }

  String getExcerciseName() {
    return exerciseName;
  }

  List<Record_> getRecords() {
    return exerciseRepository.getAllRecordsByExerciseID(exerciseID);
  }

  void deleteRecordById(String id) {
    recordRepository.deleteRecordById(exerciseName, id);
  }

}
