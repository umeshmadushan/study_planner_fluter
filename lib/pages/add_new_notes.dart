import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_planner_fluter/models/course_model.dart';
import 'package:study_planner_fluter/models/note_model.dart';
import 'package:study_planner_fluter/services/database/note_service.dart';
import 'package:study_planner_fluter/util/util_functions.dart';
import 'package:study_planner_fluter/widgets/custom_button.dart';
import 'package:study_planner_fluter/widgets/custom_input_filed.dart';

class AddNewNotes extends StatefulWidget {
  final Course course;

  AddNewNotes({
    super.key,
    required this.course,
  });

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _sectionController = TextEditingController();

  final TextEditingController _refferencesController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _selectedImage;

  //Method to pick image from gallery
  Future<void> _pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  //submit form
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final NoteModel note = NoteModel(
          id: "",
          title: _titleController.text,
          description: _descriptionController.text,
          section: _sectionController.text,
          refference: _refferencesController.text,
          imageData: _selectedImage != null ? File(_selectedImage!.path) : null,
        );

        await NoteService().createNote(widget.course.id, note);
        showSnackBar(context: context, text: "Note added succesfully!");

        await Future.delayed(const Duration(seconds: 2));
        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);
        showSnackBar(context: context, text: "Note added failed!");
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
                  'Add New Note',
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
                    controller: _titleController,
                    labeltext: 'Title',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the title';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                    controller: _descriptionController,
                    labeltext: 'Description',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the description';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                    controller: _sectionController,
                    labeltext: 'Duration',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the assignmet duration';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 5,
                ),
                CustomInputFiled(
                    controller: _refferencesController,
                    labeltext: 'Refference',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter the refference';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                const Divider(),
                const Text(
                  'Upload Note Image, for better understanding and quick revision.',
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(text: 'Upload Note Image', onPressed: _pickImage),
                const SizedBox(
                  height: 16,
                ),
                _selectedImage != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected Image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(_selectedImage!.path),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        "No Image selected",
                        style: TextStyle(fontSize: 16, color: Colors.white60),
                      ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Add Note",
                  onPressed: () => _submitForm(context),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
