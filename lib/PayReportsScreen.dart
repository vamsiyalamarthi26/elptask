import 'package:elp_task1/service/firebase_service.dart';
import 'package:flutter/material.dart';

import 'models/payreport_model.dart';

class PayReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                EmployeeData data = EmployeeData(
                  employeeNumber: 1234,
                  month: 3,
                  year: 2024,
                  employeeName: 'TEST User',
                  dataFormatVersion: 1,
                  header: [
                    Header(
                      id: '1_1_1',
                      position: 0,
                      name: 'Date',
                      value: '04/10/2024',
                    ),
                    Header(
                      id:"1_1_1",
                      position:1,
                      name:"Time",
                      value:"17:18"
                    ),
                    Header(
                      id:"1_1_2",
                      position:0,
                      name:"Emp#",
                      value:"6014"
                    ),
                    Header(
                      id:"1_1_2",
                      position:1,
                      name:"Name",
                      value:"Walker, Toni"
                    ),
                    Header(
                      id:"1_2_1",
                      position:0,
                      name:"",
                      value:"FA Payroll Report for Mar 2024",
                    ),
                    Header(
                      id:"1_2_2",
                      position:0,
                      name:"POS",
                      value:"FA"
                    ),
                    Header(
                      id:"1_2_2",
                      position:1,
                      name:"Base",
                      value:"MSP"
                    ),
                    Header(
                      id:"1_2_2",
                      position:2,
                      name:"Line Type",
                      value:"Regular"
                    ),
                  ],
                  body: [
                    Body(
                      dates: '02',
                      datesCss: {},
                      hasPrgDetails: false,
                      pairingStartDate: '2024-03-02',
                      pairingEndDate: '2024-03-02',
                      prgEvent: 'VCN3',
                      awd: 154,
                      totalCredit: 154,
                      startEditedHistory: [
                        EditedHistory(
                          oldValue: null,
                          newValue: 30,
                          comment: 'ELP Testing',
                          modifiedBy: 'Erwin ELP',
                          modifiedTime: 1713714730427,
                        ),
                      ],
                    ),
                  ],
                  summary: [
                    Summary(
                      id: '1_2_1',
                      position: 0,
                      name: 'Straight Hrs:',
                      value: ['80:33'],
                      customType: 'none',
                    ),
                  ],
                  summaryTitles: [
                    SummaryTitle(
                      id: '1_4_1',
                      defaultTitle: '2024 Banks',
                      value: [],
                      titleCSS: {
                        'fontWeight': 'bold',
                        'textAlign': 'center',
                        'borderBottom': '1px solid green',
                      },
                    ),
                  ],
                  gridColumns: [
                    GridColumn(
                      dataField: 'dates',
                      caption: 'Dates',
                    ),
                  ],
                  bodyListView: [
                    BodyListView(
                      pairingEventWithDate: 'VCN3 on 02',
                      hasPrgDetails: false,
                      topSection: [],
                      middleSection: [
                        'Credit: 02:34       Total Credit: 02:34       ',
                      ],
                      bottomSection: [],
                      bodyTotals: [
                        BodyTotal(
                          key: 'Credit',
                          value: '02:34',
                        ),
                        BodyTotal(
                          key: 'Total Credit',
                          value: '02:34',
                        ),
                      ],
                    ),
                  ],
                );

                await FirebaseService().addEmployeeData(data);
              },
              child: Text('Add Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<EmployeeData> data = await FirebaseService().getEmployeeData();
                data.forEach((element) {
                  print('Employee Name: ${element.employeeName}, Month: ${element.month}, Year: ${element.year}');
                });
              },
              child: Text('Get Data'),
            ),
          ],
        ),
      ),
    );
  }
}
