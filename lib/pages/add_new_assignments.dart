import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_fluter/models/assignmet_model.dart';
import 'package:study_planner_fluter/models/course_model.dart';
import 'package:study_planner_fluter/services/database/assignments_service.dart';
import 'package:study_planner_fluter/util/util_functions.dart';
import 'package:study_planner_fluter/widgets/custom_button.dart';
import 'package:study_planner_fluter/widgets/custom_input_filed.dart';

class AddNewAssignments extends StatelessWidget {
  final Course course;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _assignmentNameController =
      TextEditingController();
  final TextEditingController _assignmentDescriptionController =
      TextEditingController();
  final TextEditingController _assignmentDurationController =
      TextEditingController();

  final ValueNotifier<DateTime> _selectedDate =
      ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<TimeOfDay> _selectedTime =
      ValueNotifier<TimeOfDay>(TimeOfDay.now());

  AddNewAssignments({
    super.key,
    required this.course,
  }) {
    _selectedDate.value = DateTime.now();
    _selectedTime.value = TimeOfDay.now();
  }

  //Date Picker
  //ctx ona namak
  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      initialDate: _selectedDate.value,
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }
  }

  //Time Picker
  Future<void> _selectTime(BuildContext ctx) async {
    final TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: _selectedTime.value,
    );
    if (picked != null && picked != _selectedTime.value) {
      _selectedTime.value = picked;
    }
  }

  //submit form
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        //create a new assignment
        final AssignmentModel assignment = AssignmentModel(
          id: "",
          name: _assignmentNameController.text,
          description: _assignmentDescriptionController.text,
          duration: _assignmentDurationController.text,
          dueDate: _selectedDate.value,
          dueTime: _selectedTime.value,
        );
        //add the assignment to the db
        AssignmentsService().createAssignment(course.id, assignment);
        showSnackBar(context: context, text: "Assignment added successfully!");
        await Future.delayed(const Duration(seconds: 2));
        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);
        showSnackBar(context: context, text: "Assignment added failed!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Assignment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "description",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputFiled(
                    controller: _assignmentNameController,
                    labeltext: 'Assignments name',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the assignmet name';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                    controller: _assignmentDescriptionController,
                    labeltext: 'Assignment Description',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the assignmet description';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                    controller: _assignmentDurationController,
                    labeltext: 'Duration',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the assignmet duration';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                const Divider(),
                const Text(
                  'Due Date and Time',
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                const SizedBox(
                  height: 16,
                ),
                ValueListenableBuilder<DateTime>(
                    valueListenable: _selectedDate,
                    builder: (context, date, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Date : ${date.toLocal().toString().split(" ")[0]}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectDate(context),
                            icon: const Icon(Icons.calendar_today),
                          ),
                        ],
                      );
                    }),
                ValueListenableBuilder<TimeOfDay>(
                    valueListenable: _selectedTime,
                    builder: (context, time, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Time : ${time.format(context)}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectTime(context),
                            icon: const Icon(Icons.access_time),
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: "Add Assignment",
                  onPressed: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
