import 'package:flutter/material.dart';
import 'package:gym_progression_tracker/locator/locator.dart';
import 'package:gym_progression_tracker/model/excercise.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/model/user.dart';
import 'package:gym_progression_tracker/repository/exercise_repository.dart';
import 'package:gym_progression_tracker/repository/record_repository.dart';
import 'package:gym_progression_tracker/repository/user_repository.dart';
import 'package:gym_progression_tracker/view/excercise_menu_view.dart';
import 'package:gym_progression_tracker/view/excercise_selection_view.dart';
import 'package:gym_progression_tracker/view/profile_view.dart';
import 'package:gym_progression_tracker/viewmodel/excercise_menu_viewmodel.dart';
import 'package:gym_progression_tracker/viewmodel/excercises_selection_viewmodel.dart';
import 'package:gym_progression_tracker/viewmodel/profile_viewmodel.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ExcerciseAdapter());
  Hive.registerAdapter(RecordAdapter());
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox('cameraImages');
  await Hive.openBox<User>('user');

  final userBox = Hive.box<User>('user');
  if (userBox.get('user') == null) {
    userBox.put('user', User(excercises: [], name: "", age: 0, bodyFatPercentage: 0));
  }

  final UserRepository userRepository = UserRepository(userBox);
  final ExerciseRepository exerciseRepository = ExerciseRepository(userRepository);
  final RecordRepository recordRepository = RecordRepository(userRepository);

  locator.register<UserRepository>(userRepository);
  locator.register<ExerciseRepository>(exerciseRepository);
  locator.register<RecordRepository>(recordRepository);

  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  late User userData;
  late ExcerciseMenuViewmodel emviewmodel;
  late ExcercisesSelectionViewmodel esviewmodel;
  late ProfileViewmodel pviewmodel;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    emviewmodel = ExcerciseMenuViewmodel(exerciseRepository: locator.get<ExerciseRepository>(), recordRepository: locator.get<RecordRepository>())..init();
    esviewmodel = ExcercisesSelectionViewmodel(exerciseRepository: locator.get<ExerciseRepository>())..init();
    pviewmodel = ProfileViewmodel(userRepository: locator.get<UserRepository>())..init();

    pages = [
      ExcerciseMenuView(viewmodel: emviewmodel),
      ExcerciseSelectionView(viewmodel: esviewmodel),
      ProfileView(viewmodel: pviewmodel)
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: buildPageHeadline(),
        ),
        floatingActionButton: buildFloatingActionButton(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.man), label: 'Profile'),
          ],
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),
    );
  }

  Widget? buildPageHeadline() {
    switch (selectedIndex) {
      case 0:
        return Text("Exercise Menu");
      case 1:
        return Text("Exercises");
      case 2:
        return Text("Profil");
      
      default:
        return null;
    }
  }

  Widget? buildFloatingActionButton() {
    switch (selectedIndex) {
      case 0:
        return FloatingActionButton(
          onPressed: () => emviewmodel.onFloatingActionButton(),
          child: Icon(Icons.add),
        );
      default:
        return null;
    }
  }
}

