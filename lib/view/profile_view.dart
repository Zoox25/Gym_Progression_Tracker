import 'package:flutter/material.dart';
import 'package:gym_progression_tracker/viewmodel/profile_viewmodel.dart';
import 'package:gym_progression_tracker/widgets/camera_widget.dart';

class ProfileView extends StatefulWidget {
  final ProfileViewmodel viewmodel;
  const ProfileView({super.key, required this.viewmodel});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bfpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.viewmodel.getUserName();
    ageController.text = widget.viewmodel.getUserAge().toString();
    weightController.text = widget.viewmodel.getUserWeight().toString();
    bfpController.text = widget.viewmodel.getUserBFP().toString();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewmodel,
      builder: (context, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) => {widget.viewmodel.setUserName(value)},
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: ageController,
                      onChanged: (value) => {widget.viewmodel.setUserAge(int.parse(value))},
                      decoration: InputDecoration(
                        hintText: "Age",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: weightController,
                      onChanged: (value) => {widget.viewmodel.setUserWeight(double.parse(value))},
                      decoration: InputDecoration(
                        hintText: "Weight",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: bfpController,
                      onChanged: (value) => {widget.viewmodel.setUserBFP(double.parse(value))},
                      decoration: InputDecoration(
                        hintText: "BodyFat",
                      ),
                    ),
                  ),
                ],
              ),
              CameraWidget()
            ],
          ),
        );
      }
    );
  }
  
}