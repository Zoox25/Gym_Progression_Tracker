import 'package:gym_progression_tracker/model/excercise.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/repository/user_repository.dart';

class ExerciseRepository {
  final UserRepository userRepo;

  ExerciseRepository(this.userRepo);

  List<Excercise> getAll() {
    return userRepo.getUser()?.excercises ?? [];
  }

  void addExercise(Excercise exercise) {
    final user = userRepo.getUser();
    if (user == null) return;

    user.excercises.add(exercise);
    userRepo.saveUser(user);
  }

  void deleteExerciseByID(String excerciseID) {
    final user = userRepo.getUser();
    if (user == null) return;

    user.excercises.removeWhere((e) => e.id == excerciseID);
    userRepo.saveUser(user);
  }

  List<Record_> getAllRecordsByExerciseID(String excerciseID) {
    List<Excercise> excercises = userRepo.getUser()?.excercises ?? [];
    for (Excercise excercise in excercises) {
      if (excercise.id == excerciseID) {
        return excercise.records;
      }
    }
    return [];
  }
}
