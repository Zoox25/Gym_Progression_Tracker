import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/repository/user_repository.dart';
import 'package:hive_flutter/adapters.dart';

class ProfileViewmodel extends ChangeNotifier {
  UserRepository userRepository;
  late final StreamSubscription subscription;

  ProfileViewmodel({required this.userRepository});

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

  bool setUserName(String userName) {
    userRepository.setName(userName);
    return true;
  }

  bool setUserAge(int age) {
    userRepository.setAge(age);
    return true;
  }

  bool setUserWeight(double weight) {
    userRepository.setWeight(weight);
    return true;
  }

  bool setUserBFP(double bfp) {
    userRepository.setBFP(bfp);
    return true;
  }

  String getUserName() {
    return userRepository.getName();
  }

  int getUserAge() {
    return userRepository.getAge();
  }

  double getUserWeight() {
    return userRepository.getWeight();
  }

  double getUserBFP() {
    return userRepository.getBFP();
  }
}
