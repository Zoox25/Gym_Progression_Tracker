import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'record.g.dart';

@HiveType(typeId: 2)
class Record_ {
  @HiveField(0)
  String id;

  @HiveField(1)
  double weight;
  
  @HiveField(2)
  int reps;

  @HiveField(3)
  DateTime date;

  Record_({required this.weight, required this.reps, required this.date}) : id = Uuid().v4();

}
