// api_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  Future<void> uploadScheduleData(List<Map<String, dynamic>> scheduleData) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (var data in scheduleData) {
      var docRef = firestore.collection('schedules').doc();
      batch.set(docRef, data);
    }

    await batch.commit();
  }
}
