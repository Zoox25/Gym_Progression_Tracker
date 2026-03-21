import 'package:gym_progression_tracker/model/excercise.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  String id;

  @HiveField(1)
  List<Excercise> excercises = [];

  @HiveField(2)
  String name = "";
  
  @HiveField(3)
  int age = 0;
  
  @HiveField(4)
  double weight = 0;
  
  @HiveField(5)
  double bodyFatPercentage = 0;

  User({required this.excercises, required this.name, required this.age, required this.bodyFatPercentage}) : id = Uuid().v4();

  bool setName(String name) {
    this.name = name;
    return true;
  }

  bool addExcercise(String name, String description) {
    excercises.add(Excercise(name: name, description: description, records: []));
    return true;
  }

  bool addRecord(String excerciseName, double weight, int reps, DateTime date) {
    Excercise? excercise = getExcercise(excerciseName);
    if (excercise == null) {
      return false;
    }
    bool success = excercise.addRecord(weight, reps, date);
    return success;
  }

  Excercise? getExcercise(String excerciseName) {
    for (Excercise excercise in excercises) {
      if (excerciseName == excercise.name) {
        return excercise;
      }
    }
    return null;
  }

  bool setAge(int age) {
    this.age = age;
    return true;
  }

  bool setWeight(double weight) {
    this.weight = weight;
    return true;
  }

  bool setBFP(double bfp) {
    bodyFatPercentage = bfp;
    return true;
  }

  String getName() {
    return name;
  }

  int getAge() {
    return age;
  }

  double getWeight() {
    return weight;
  }

  double getBFP() {
    return bodyFatPercentage;
  }

}
