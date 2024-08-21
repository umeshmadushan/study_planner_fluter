import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_fluter/models/assignmet_model.dart';

class AssignmentsService {
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection("courses");

  //create a new assignment in to a course
  Future<void> createAssignment(
    String courseId, AssignmentModel assignment) async {
      try {
        final Map<String, dynamic> data = assignment.toJson();

        //assignment ref
        final CollectionReference assignmentCollection =
            courseCollection.doc(courseId).collection("assignments");

        DocumentReference docRef = await assignmentCollection.add(data);

        //update id
        await docRef.update({'id': docRef.id});
        print("Assignment Saved");

      } catch (error) {
        print(error);
      }
  }
}
