import 'package:elp_task1/models/payreport_model.dart';
import 'package:elp_task1/models/schedule_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeGridView extends StatelessWidget {
  final List<EmployeeData> items;

  EmployeeGridView({required this.items});


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("item.pairingEventWithDate"),
                Text("item.middleSection"),
                Text( 'line3'//'Credit: ${item.bodyTotals[0].value}  Total Credit: ${item.bodyTotals[1].value}'"
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}