import 'package:flutter/material.dart';
import 'package:gym_progression_tracker/model/record.dart';
import 'package:gym_progression_tracker/viewmodel/record_menu_viewmodel.dart';
import 'package:intl/intl.dart';


class RecordMenuView extends StatefulWidget {
  final RecordMenuViewmodel viewmodel;
  const RecordMenuView({super.key, required this.viewmodel});

  @override
  State<RecordMenuView> createState() => _RecordMenuViewState();
}

class _RecordMenuViewState extends State<RecordMenuView> {
  @override
  Widget build(BuildContext context) {
    List<Record_> records = widget.viewmodel.getRecords();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool confirmed = await showAreYouSureDialog(context);

            if (confirmed) {
              widget.viewmodel.deleteExercise();
              Navigator.pop(context);
            }
          },
          child: Icon(Icons.delete),
      ),
      appBar: AppBar(
        title: Text(widget.viewmodel.getExcerciseName()),
      ),
      body: AnimatedBuilder(
        animation: widget.viewmodel,
        builder: (context, asyncSnapshot) {
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (BuildContext context, int index) {
              
              DateTime date = records[index].date;
              double weight = records[index].weight;
              int reps = records[index].reps;
              String id = records[index].id;
              
              return Center(
                child: Row(
                  children: [
                    Expanded(child: Text(DateFormat('yyyy-MM-dd').format(date))),
                    Expanded(child: Text(weight.toString())),
                    Expanded(child: Text(reps.toString())),
                    GestureDetector(
                      onTap: () => widget.viewmodel.deleteRecordById(id),
                      child: Icon(Icons.remove)
                    ),
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }

  Future<bool> showAreYouSureDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you really want to delete this Exercise and all corresponding records?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"),
            ),
          ],
        );
      },
    ) ?? false; // returns false if dialog is dismissed
  }


}
