import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskverse/controllers/authController.dart';
import 'package:taskverse/models/List.dart';
import '../models/FTask.dart';

class DataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late CollectionReference collectionRef;
  late CollectionReference allTaskCollectionRef;

  late Query doneQuery;
  late Query scheduledQuery;
  late Query todayQuery;

  RxList<Array> lists = RxList<Array>([]);
  RxList<FTask> allTask = RxList<FTask>([]);
  RxList<FTask> doneTask = RxList<FTask>([]);
  RxList<FTask> scheduledTask = RxList<FTask>([]);
  RxList<FTask> todayTask = RxList<FTask>([]);

  @override
  void onInit() {
    super.onInit();

    String uid = Get.find<AuthController>().user!.uid;

    collectionRef = _firestore.collection("users").doc(uid).collection("lists");

    allTaskCollectionRef =
        _firestore.collection("users").doc(uid).collection("allTask");

    doneQuery = allTaskCollectionRef.where("done", isEqualTo: true);

    scheduledQuery =
        allTaskCollectionRef.where("dateAndTimeEnabled", isEqualTo: true);

    todayQuery = allTaskCollectionRef.where("date",
        isEqualTo: DateFormat("MM/dd/yyyy").format(DateTime.now()));

    lists.bindStream(getList());
    allTask.bindStream(getAllTask());
    doneTask.bindStream(getDoneTask());
    scheduledTask.bindStream(getScheduledTask());
    todayTask.bindStream(getTodayTask());
  }

  Stream<List<Array>> getList() => collectionRef
      .snapshots()
      .map((query) => query.docs.map((item) => Array.fromMap(item)).toList());

  Stream<List<FTask>> getAllTask() => allTaskCollectionRef
      .snapshots()
      .map((query) => query.docs.map((item) => FTask.fromMap(item)).toList());

  Stream<List<FTask>> getDoneTask() => doneQuery
      .snapshots()
      .map((query) => query.docs.map((item) => FTask.fromMap(item)).toList());

  Stream<List<FTask>> getScheduledTask() => scheduledQuery
      .snapshots()
      .map((query) => query.docs.map((item) => FTask.fromMap(item)).toList());

  Stream<List<FTask>> getTodayTask() => todayQuery
      .snapshots()
      .map((query) => query.docs.map((item) => FTask.fromMap(item)).toList());
}
