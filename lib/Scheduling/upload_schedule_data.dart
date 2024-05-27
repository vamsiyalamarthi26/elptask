// upload_schedule_data.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final scheduleData = [
  {
    "emplNo": 1234,
    "prgNo": "M4453",
    "prgDate": "20240405",
    "startDate": "20240405",
    "endDate": "20240407",
    "startTime": "15:07",
    "endTime": "00:31",
    "prgLegNo": 45,
    "scheduleNo": "430318M44532024040545",
    "eventType": "pairing",
    "contained": false,
    "spansWeekend": 1,
    "roundedEndTime": "00:00",
    "layer": 0,
  },
  // Add more entries here
];

Future<void> uploadScheduleData() async {
  await Firebase.initializeApp();
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  for (var data in scheduleData) {
    var docRef = firestore.collection('schedules').doc();
    batch.set(docRef, data);
  }

  await batch.commit();
  print("Schedule data uploaded successfully.");
}

void main() async {
  await uploadScheduleData();
}
