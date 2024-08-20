import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner_fluter/pages/add_newcourse.dart';
import 'package:study_planner_fluter/pages/home.dart';

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
          })
    ],
  );
}
