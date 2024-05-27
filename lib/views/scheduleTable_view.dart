import 'dart:convert';
import 'package:flutter/material.dart';

import '../payreport_json/payreport_json.dart';

class ScheduleTableView extends StatefulWidget {
  @override
  _ScheduleTableViewState createState() => _ScheduleTableViewState();
}

class _ScheduleTableViewState extends State<ScheduleTableView> {
  List<Map<String, dynamic>> jsonData = [];

  @override
  void initState() {
    super.initState();
    _parseJsonData();
  }

  void _parseJsonData() {
    // Parse the JSON string into a list of maps
    jsonData = jsonDecode(JsonData.jsonString).cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50], // Background color for the full page
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: jsonData.map((data) => _buildTable(data)).toList(),
      ),
    );
  }

  Widget _buildTable(Map<String, dynamic> data) {
    List<TableRow> rows = [
      TableRow(
        children: [
          TableCell(child: Text('Dates')),
          TableCell(child: Text('Page Event')),
          TableCell(child: Text('Start Date')),
          TableCell(child: Text('End Date')),
          TableCell(child: Text('Rost ASN Code')),
        ],
      ),
    ];

    for (var entry in data['body']) {
      rows.add(
        TableRow(
          children: [
            TableCell(child: Text(entry['dates'] ?? '')),
            TableCell(child: Text(entry['prg_event'] ?? '')),
            TableCell(child: Text(entry['pairing_start_date'] ?? '')),
            TableCell(child: Text(entry['pairing_end_date'] ?? '')),
            TableCell(child: Text(data['bodyListView'][0]['bodyTotals'][0]['value'] ?? '')),
          ],
        ),
      );
    }

    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
      },
      children: rows,
    );
  }
}
