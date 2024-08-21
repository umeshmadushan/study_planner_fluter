import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner_fluter/models/note_model.dart';
import 'package:study_planner_fluter/services/database/store_images.dart';

class NoteService {
  final CollectionReference courseCollection =
      FirebaseFirestore.instance.collection("courses");

  //store a note
  Future<void> createNote(String courseId, NoteModel note) async {
    try {
      // Store the image in firebase storage if it exists
      String? imageUrl;
      if (note.imageData != null) {
        imageUrl = await StorageService().uploadImage(
          noteImage: note.imageData!,
          courseId: courseId,
        );
      }

      //Create a new note object
      final NoteModel newNote = NoteModel(
        id: "",
        title: note.title,
        description: note.description,
        section: note.section,
        refference: note.refference,
        imageUrl: imageUrl,
      );

      //Add the note to the collection
      final DocumentReference docRef = await courseCollection
          .doc(courseId)
          .collection("notes")
          .add(newNote.toJson());

      await docRef.update({'id': docRef.id});
      print("Stored note!");
    } catch (error) {
      print(error);
    }
  }
}
