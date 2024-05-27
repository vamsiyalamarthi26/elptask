import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadScheduleData() async {
  final data = {
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
    "layer": 0
  };

  await FirebaseFirestore.instance.collection('schedules').add(data);
}
