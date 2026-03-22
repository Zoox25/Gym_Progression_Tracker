import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/repository/user_repository.dart';

class RecordRepository {
  final UserRepository userRepo;

  RecordRepository(this.userRepo);

  void deleteRecordById(String exerciseName, String id) {
    final user = userRepo.getUser();
    if (user == null) return;

    final exercise = user.excercises.firstWhere(
      (e) => e.name == exerciseName
    );

    exercise.records.removeWhere((r) => r.id == id);
    userRepo.saveUser(user);
  }

  void addRecord(String exerciseID, Record_ record) {
    final user = userRepo.getUser();
    if (user == null) return;

    final exercise = user.excercises.firstWhere(
      (e) => e.id == exerciseID
    );

    exercise.records.add(record);
    userRepo.saveUser(user);
  }
}
