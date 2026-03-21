import 'package:gym_progression_tracker/model/record.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'excercise.g.dart';

@HiveType(typeId: 1)
class Excercise {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  List<Record_> records = [];

  Excercise({required this.name, required this.description, required this.records}) : id = Uuid().v4();

  bool addRecord(double weight, int reps, DateTime date) {
    records.add(Record_(weight: weight, reps: reps, date: date));
    return true;
  }

  bool removeRecord(double weight, int reps, DateTime date) {
    for (Record_ record in records) {
      if (record.date == date && record.weight == weight && record.reps == reps) {
        records.remove(record);
        return true;
      }
    }
    return false;
  }
}
