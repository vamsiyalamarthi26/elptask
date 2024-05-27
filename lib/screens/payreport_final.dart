import 'package:elp_task1/models/payreport_model.dart';
import 'package:flutter/cupertino.dart';

import '../views/scheduleTable_view.dart';
import '../widget/gridview_widget.dart';
import '../widget/listview_widget.dart';

class PayReportFinal extends StatefulWidget {
  const PayReportFinal({super.key});

  @override
  State<PayReportFinal> createState() => _PayReportFinalState();
}

class _PayReportFinalState extends State<PayReportFinal> {

  final List<EmployeeData> items = [];
   //List<EmployeeData> tableValue =

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Table View', style: TextStyle(fontSize: 20)),
          ScheduleTableView(),
          Text('List View', style: TextStyle(fontSize: 20)),
          EmployeeListView(items: items),
          /*SizedBox(height: 20),
          Text('Grid View', style: TextStyle(fontSize: 20)),
          EmployeeGridView(items: items),
          SizedBox(height: 20),*/
        ],
      ),
    );

  }
}
