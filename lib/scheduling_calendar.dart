// scheduling_calendar.dart
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SchedulingCalendar extends StatefulWidget {
  @override
  _SchedulingCalendarState createState() => _SchedulingCalendarState();
}

class _SchedulingCalendarState extends State<SchedulingCalendar> {
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchScheduleData();
  }

  Future<void> _fetchScheduleData() async {
    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore.collection('schedules').get();

    final appointments = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final startDate = DateTime.parse(data['startDate']);
      final endDate = DateTime.parse(data['endDate']);
      final startTime = DateFormat.Hm().parse(data['startTime']);
      final endTime = DateFormat.Hm().parse(data['endTime']);

      final startDateTime = DateTime(
        startDate.year, startDate.month, startDate.day,
        startTime.hour, startTime.minute,
      );

      final endDateTime = DateTime(
        endDate.year, endDate.month, endDate.day,
        endTime.hour, endTime.minute,
      );

      return Appointment(
        startTime: startDateTime,
        endTime: endDateTime,
        subject: 'PrgNo: ${data['prgNo']}\nLeg No: ${data['prgLegNo']}\nType: ${data['eventType']}',
        color: data['eventType'] == 'pairing' ? Colors.pink : Colors.blue,
        isAllDay: false,
      );
    }).toList();

    setState(() {
      _appointments = appointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Schedule')),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: AppointmentDataSource(_appointments),
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          agendaStyle: AgendaStyle(
            backgroundColor: Colors.white10,
          ),
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        ),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
