import 'package:flutter/material.dart';
import 'package:gym_progression_tracker/viewmodel/excercise_creation_viewmodel.dart';


class ExcerciseCreationView extends StatefulWidget {
  final ExcerciseCreationViewmodel viewmodel;

  const ExcerciseCreationView({super.key, required this.viewmodel});

  @override
  State<ExcerciseCreationView> createState() => _ExcerciseCreationViewState();
}

class _ExcerciseCreationViewState extends State<ExcerciseCreationView> {
  final excerciseName = TextEditingController();
  final excerciseDescription = TextEditingController();

  void onSubmit() {
    widget.viewmodel.addExcercise(excerciseName.text, excerciseDescription.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: onSubmit,
          child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: Text("Exercise Creation"),
      ),
      body: AnimatedBuilder(
        animation: widget.viewmodel,
        builder: (context, _) {
          return Center(
            child: Column(
              children: [
                TextField(
                  controller: excerciseName,
                  decoration: InputDecoration(
                    hintText: "Exercise Name",
                  ),
                ),
                TextField(
                  controller: excerciseDescription,
                  decoration: InputDecoration(
                    hintText: "Exercise Description",
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
