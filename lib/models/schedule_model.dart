// schedule_model.dart
import 'dart:convert';

import 'package:flutter/material.dart';

class Schedule {
  final int emplNo;
  final String prgNo;
  final DateTime prgDate;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int prgLegNo;
  final String scheduleNo;
  final String eventType;
  final bool contained;
  final int spansWeekend;
  final TimeOfDay roundedEndTime;
  final int layer;

  Schedule({
    required this.emplNo,
    required this.prgNo,
    required this.prgDate,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.prgLegNo,
    required this.scheduleNo,
    required this.eventType,
    required this.contained,
    required this.spansWeekend,
    required this.roundedEndTime,
    required this.layer,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      emplNo: json['emplNo'],
      prgNo: json['prgNo'],
      prgDate: DateTime.parse(json['prgDate']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      startTime: TimeOfDay(hour: int.parse(json['startTime'].split(':')[0]), minute: int.parse(json['startTime'].split(':')[1])),
      endTime: TimeOfDay(hour: int.parse(json['endTime'].split(':')[0]), minute: int.parse(json['endTime'].split(':')[1])),
      prgLegNo: json['prgLegNo'],
      scheduleNo: json['scheduleNo'],
      eventType: json['eventType'],
      contained: json['contained'],
      spansWeekend: json['spansWeekend'],
      roundedEndTime: TimeOfDay(hour: int.parse(json['roundedEndTime'].split(':')[0]), minute: int.parse(json['roundedEndTime'].split(':')[1])),
      layer: json['layer'],
    );
  }
}

class HeaderItem {
  final String id;
  final int position;
  final String name;
  final String value;

  HeaderItem({
    required this.id,
    required this.position,
    required this.name,
    required this.value,
  });

  factory HeaderItem.fromJson(Map<String, dynamic> json) {
    return HeaderItem(
      id: json['id'],
      position: json['position'],
      name: json['name'],
      value: json['value'],
    );
  }
}

class BodyItem {
  final String dates;
  final Map<String, dynamic> datesCss;
  final bool hasPrgDetails;
  final String pairingStartDate;
  final String pairingEndDate;
  final String prgEvent;
  final int awd;
  final int totalCredit;
  //final List<StartEditedHistoryItem> startEditedHistory;

  BodyItem({
    required this.dates,
    required this.datesCss,
    required this.hasPrgDetails,
    required this.pairingStartDate,
    required this.pairingEndDate,
    required this.prgEvent,
    required this.awd,
    required this.totalCredit,
    //required this.startEditedHistory,
  });

  factory BodyItem.fromJson(Map<String, dynamic> json) {
    return BodyItem(
      dates: json['dates'],
      datesCss: json['dates_css'],
      hasPrgDetails: json['has_prg_details'],
      pairingStartDate: json['pairing_start_date'],
      pairingEndDate: json['pairing_end_date'],
      prgEvent: json['prg_event'],
      awd: json['awd'],
      totalCredit: json['total_credit'], //startEditedHistory: [],
      //startEditedHistory: List<StartEditedHistoryItem>.from(json['start_edited_history'].map((x) => StartEditedHistoryItem.fromJson(x))),
    );
  }

  static List<Schedule> parseJson(String jsonString) {
    final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Schedule>((json) => Schedule.fromJson(json)).toList();
  }
}

