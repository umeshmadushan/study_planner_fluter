import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_fluter/models/course_model.dart';

class CourseService {
  // create the firestore collection refference
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection('courses'); // 'courses' is collection name

  // Add a new course
  Future<void> createNewCourse(Course course) async {
    try {
      // Convert the course object to a jsonmap
      final Map<String, dynamic> data = course.toJson();

      // Add the course to the collection
      final DocumentReference docRef = await courseCollection.add(data);

      // Update the course document with the generated ID
      await docRef.update({'id': docRef.id});
      print("course saved");
    } catch (error) {
      print("Error creating course: $error");
    }
  }

  // get all courses as a stream List of Course
  Stream<List<Course>> get courses {
    try {
      return courseCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Course.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (error) {
      print(error);
      return Stream.empty();
    }
  }
}
