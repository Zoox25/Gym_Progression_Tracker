import 'package:gym_progression_tracker/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserRepository {
  final Box<User> _box;

  UserRepository(this._box);

  User? getUser() => _box.get('user');

  void saveUser(User user) {
    _box.put('user', user);
  }

  void setName(String name) {
    final user = getUser();
    if (user == null) {
      return;
    }

    user.name = name;
    saveUser(user);
  }

  void setAge(int age) {
    final user = getUser();
    if (user == null) {
      return;
    }

    user.age = age;
    saveUser(user);
  }

  void setWeight(double weight) {
    final user = getUser();
    if (user == null) {
      return;
    }

    user.weight = weight;
    saveUser(user);
  }

  void setBFP(double bfp) {
    final user = getUser();
    if (user == null) {
      return;
    }

    user.bodyFatPercentage = bfp;
    saveUser(user);
  }

  String getName() {
    final user = getUser();
    if (user == null) {
      return "";
    }

    return user.name;
  }

  int getAge() {
    final user = getUser();
    if (user == null) {
      return 0;
    }

    return user.age;
  }

  double getWeight() {
    final user = getUser();
    if (user == null) {
      return 0;
    }

    return user.weight;
  }

  double getBFP() {
    final user = getUser();
    if (user == null) {
      return 0;
    }

    return user.bodyFatPercentage;
  }
}
