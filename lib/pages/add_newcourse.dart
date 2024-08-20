import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_fluter/models/course_model.dart';
import 'package:study_planner_fluter/services/course_service.dart';
import 'package:study_planner_fluter/util/util_functions.dart';
import 'package:study_planner_fluter/widgets/custom_button.dart';
import 'package:study_planner_fluter/widgets/custom_input_filed.dart';

class AddNewCourse extends StatelessWidget {
  AddNewCourse({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseScheduleController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      //save form
      _formKey.currentState?.save();

      //Add course to Firebase or any other storage here
      try {
        final Course course = Course(
          id: '',
          name: _courseNameController.text,
          description: _courseDescriptionController.text,
          duartion: _courseDurationController.text,
          schedule: _courseScheduleController.text,
          instructor: _courseInstructorController.text,
        );
        await CourseService().createNewCourse(course);
        showSnackBar(context: context, text: 'Course added succesfully');
        //Navigate to the home page
        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);
        showSnackBar(context: context, text: 'Failed to add course!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add New Course",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Fill in the details below to add a new course.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInputFiled(
                  controller: _courseNameController,
                  labeltext: "Course Name",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter course name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                  controller: _courseDescriptionController,
                  labeltext: "Course Description",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter course description";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                  controller: _courseDurationController,
                  labeltext: "Course Duration",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter course duration";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                  controller: _courseScheduleController,
                  labeltext: "Course Shedule",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter course schedule";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                  controller: _courseInstructorController,
                  labeltext: "Course Instructor",
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter course instructor";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Add Course", onPressed: () => {_submitForm(context)})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
