import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskverse/models/User.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("users").doc(uid).get();

      return UserModel.fromDocumentSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLista(String uid, String title) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("lists")
          .add({'dateCreated': Timestamp.now(), 'title': title, 'task': []});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAllTarefa(
      String uid,
      int docId,
      String arrayTitle,
      String title,
      String details,
      Timestamp dateCreated,
      String date,
      String time,
      done,
      dateAndTimeEnabled,
      int id) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("allTask")
          .doc(docId.toString())
          .set({
        "arrayTitle": arrayTitle,
        "title": title,
        "details": details,
        "dateCreated": dateCreated,
        "date": date,
        "time": time,
        "done": done,
        "dateAndTimeEnabled": dateAndTimeEnabled,
        "id": id,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTarefa(
      String uid,
      int docId,
      String arrayTitle,
      String title,
      String details,
      Timestamp dateCreated,
      String date,
      String time,
      done,
      dateAndTimeEnabled,
      int id) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("allTask")
          .doc(docId.toString())
          .update({
        "arrayTitle": arrayTitle,
        "title": title,
        "details": details,
        "dateCreated": dateCreated,
        "date": date,
        "time": time,
        "done": done,
        "dateAndTimeEnabled": dateAndTimeEnabled,
        "id": id,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLista(String uid, String title, String id) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("lists")
          .doc(id)
          .update({
        'title': title,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLista(String uid, String id) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("lists")
          .doc(id)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllTarefa(String uid, int docId) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("allTask")
          .doc(docId.toString())
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
