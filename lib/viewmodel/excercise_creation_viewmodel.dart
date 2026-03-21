import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/excercise.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:hive_flutter/adapters.dart';

class ExcerciseCreationViewmodel extends ChangeNotifier {
  ExerciseRepository exerciseRepository;
  
  late final StreamSubscription subscription;

  ExcerciseCreationViewmodel({required this.exerciseRepository});
  
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

  bool addExcercise(String name, String description) {
    exerciseRepository.addExercise(Excercise(name: name, description: description, records: []));
    return true;
  }

}
