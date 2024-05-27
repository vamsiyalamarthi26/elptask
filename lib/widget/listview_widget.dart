import 'package:flutter/material.dart';
import 'package:elp_task1/models/payreport_model.dart';

class EmployeeListView extends StatelessWidget {
  final List<EmployeeData> items;

  EmployeeListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Set a specific height or use Expanded for flexible height
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: tile',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Middle Section: tile',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Value:tile',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
