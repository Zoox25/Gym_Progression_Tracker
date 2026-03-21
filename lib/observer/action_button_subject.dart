import 'package:gym_progression_tracker/observer/action_button_observer.dart';

abstract class ActionButtonSubject {
  void addActionButtonObserver(ActionButtonObserver observer);
  void onFloatingActionButton();
  void removeActionButtonObserver(ActionButtonObserver observer);
}
