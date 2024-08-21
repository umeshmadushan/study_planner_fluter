import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_fluter/models/course_model.dart';
import 'package:study_planner_fluter/pages/add_new_assignments.dart';
import 'package:study_planner_fluter/pages/add_new_notes.dart';
import 'package:study_planner_fluter/pages/add_newcourse.dart';
import 'package:study_planner_fluter/pages/home.dart';
import 'package:study_planner_fluter/pages/single_course_page.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: Scaffold(
          body: Center(
            child: Text("Page is not availabe!"),
          ),
        ),
      );
    },
    routes: [
      // home page
      GoRoute(
          path: "/",
          name: "home",
          builder: (context, satte) {
            return HomePage();
          }),

      //new course
      GoRoute(
          path: "/add-new-course",
          name: "add new course",
          builder: (context, state) {
            return AddNewCourse();
          }),
      //single course
      GoRoute(
          path: "/single-course",
          name: "single course",
          builder: (context, state) {
            final Course course = state.extra as Course;
            return SingleCoursePage(
              course: course,
            );
          }),
      //add new assignments
      GoRoute(
          path: "/add-new-assignment",
          name: "add new assignment",
          builder: (context, state) {
            final Course course = state.extra as Course;
            return AddNewAssignments(
              course: course,
            );
          }),
      //add new assignments
      GoRoute(
          path: "/add-new-note",
          name: "add new note",
          builder: (context, state) {
            final Course course = state.extra as Course;
            return AddNewNotes(
              course: course,
            );
          }),
    ],
  );
}
