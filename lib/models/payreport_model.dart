class EmployeeData {
  final int employeeNumber;
  final int month;
  final int year;
  final String employeeName;
  final int dataFormatVersion;
  final List<Header> header;
  final List<Body> body;
  final List<Summary> summary;
  final List<SummaryTitle> summaryTitles;
  final List<GridColumn> gridColumns;
  final List<BodyListView> bodyListView;

  EmployeeData({
    required this.employeeNumber,
    required this.month,
    required this.year,
    required this.employeeName,
    required this.dataFormatVersion,
    required this.header,
    required this.body,
    required this.summary,
    required this.summaryTitles,
    required this.gridColumns,
    required this.bodyListView,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      employeeNumber: json['employeeNumber'],
      month: json['month'],
      year: json['year'],
      employeeName: json['employeeName'],
      dataFormatVersion: json['dataFormatVersion'],
      header: (json['header'] as List).map((i) => Header.fromJson(i)).toList(),
      body: (json['body'] as List).map((i) => Body.fromJson(i)).toList(),
      summary: (json['summary'] as List).map((i) => Summary.fromJson(i)).toList(),
      summaryTitles: (json['summaryTitles'] as List).map((i) => SummaryTitle.fromJson(i)).toList(),
      gridColumns: (json['gridColumns'] as List).map((i) => GridColumn.fromJson(i)).toList(),
      bodyListView: (json['bodyListView'] as List).map((i) => BodyListView.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeNumber': employeeNumber,
      'month': month,
      'year': year,
      'employeeName': employeeName,
      'dataFormatVersion': dataFormatVersion,
      'header': header.map((i) => i.toJson()).toList(),
      'body': body.map((i) => i.toJson()).toList(),
      'summary': summary.map((i) => i.toJson()).toList(),
      'summaryTitles': summaryTitles.map((i) => i.toJson()).toList(),
      'gridColumns': gridColumns.map((i) => i.toJson()).toList(),
      'bodyListView': bodyListView.map((i) => i.toJson()).toList(),
    };
  }
}

class Header {
  final String id;
  final int position;
  final String name;
  final String value;

  Header({
    required this.id,
    required this.position,
    required this.name,
    required this.value,
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      id: json['id'],
      position: json['position'],
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position,
      'name': name,
      'value': value,
    };
  }
}

class Body {
  final String dates;
  final Map<String, dynamic> datesCss;
  final bool hasPrgDetails;
  final String pairingStartDate;
  final String pairingEndDate;
  final String prgEvent;
  final int awd;
  final int totalCredit;
  final List<EditedHistory> startEditedHistory;

  Body({
    required this.dates,
    required this.datesCss,
    required this.hasPrgDetails,
    required this.pairingStartDate,
    required this.pairingEndDate,
    required this.prgEvent,
    required this.awd,
    required this.totalCredit,
    required this.startEditedHistory,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      dates: json['dates'],
      datesCss: json['dates_css'],
      hasPrgDetails: json['has_prg_details'],
      pairingStartDate: json['pairing_start_date'],
      pairingEndDate: json['pairing_end_date'],
      prgEvent: json['prg_event'],
      awd: json['awd'],
      totalCredit: json['total_credit'],
      startEditedHistory: (json['start_edited_history'] as List)
          .map((i) => EditedHistory.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates,
      'dates_css': datesCss,
      'has_prg_details': hasPrgDetails,
      'pairing_start_date': pairingStartDate,
      'pairing_end_date': pairingEndDate,
      'prg_event': prgEvent,
      'awd': awd,
      'total_credit': totalCredit,
      'start_edited_history':
      startEditedHistory.map((i) => i.toJson()).toList(),
    };
  }
}

class EditedHistory {
  final dynamic oldValue;
  final int newValue;
  final String comment;
  final String modifiedBy;
  final int modifiedTime;

  EditedHistory({
    required this.oldValue,
    required this.newValue,
    required this.comment,
    required this.modifiedBy,
    required this.modifiedTime,
  });

  factory EditedHistory.fromJson(Map<String, dynamic> json) {
    return EditedHistory(
      oldValue: json['oldValue'],
      newValue: json['newValue'],
      comment: json['comment'],
      modifiedBy: json['modifiedBy'],
      modifiedTime: json['modifiedTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'oldValue': oldValue,
      'newValue': newValue,
      'comment': comment,
      'modifiedBy': modifiedBy,
      'modifiedTime': modifiedTime,
    };
  }
}

class Summary {
  final String id;
  final int position;
  final String name;
  final List<String> value;
  final String customType;

  Summary({
    required this.id,
    required this.position,
    required this.name,
    required this.value,
    required this.customType,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      id: json['id'],
      position: json['position'],
      name: json['name'],
      value: List<String>.from(json['value']),
      customType: json['customType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position,
      'name': name,
      'value': value,
      'customType': customType,
    };
  }
}

class SummaryTitle {
  final String id;
  final String defaultTitle;
  final List<dynamic> value;
  final Map<String, dynamic> titleCSS;

  SummaryTitle({
    required this.id,
    required this.defaultTitle,
    required this.value,
    required this.titleCSS,
  });

  factory SummaryTitle.fromJson(Map<String, dynamic> json) {
    return SummaryTitle(
      id: json['id'],
      defaultTitle: json['defaultTitle'],
      value: List<dynamic>.from(json['value']),
      titleCSS: json['titleCSS'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'defaultTitle': defaultTitle,
      'value': value,
      'titleCSS': titleCSS,
    };
  }
}

class GridColumn {
  final String dataField;
  final String caption;

  GridColumn({
    required this.dataField,
    required this.caption,
  });

  factory GridColumn.fromJson(Map<String, dynamic> json) {
    return GridColumn(
      dataField: json['dataField'],
      caption: json['caption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataField': dataField,
      'caption': caption,
    };
  }
}

class BodyListView {
  final String pairingEventWithDate;
  final bool hasPrgDetails;
  final List<dynamic> topSection;
  final List<String> middleSection;
  final List<dynamic> bottomSection;
  final List<BodyTotal> bodyTotals;

  BodyListView({
    required this.pairingEventWithDate,
    required this.hasPrgDetails,
    required this.topSection,
    required this.middleSection,
    required this.bottomSection,
    required this.bodyTotals,
  });

  factory BodyListView.fromJson(Map<String, dynamic> json) {
    return BodyListView(
      pairingEventWithDate: json['pairingEventWithDate'],
      hasPrgDetails: json['hasPrgDetails'],
      topSection: List<dynamic>.from(json['topSection']),
      middleSection: List<String>.from(json['middleSection']),
      bottomSection: List<dynamic>.from(json['bottomSection']),
      bodyTotals: (json['bodyTotals'] as List)
          .map((i) => BodyTotal.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pairingEventWithDate': pairingEventWithDate,
      'hasPrgDetails': hasPrgDetails,
      'topSection': topSection,
      'middleSection': middleSection,
      'bottomSection': bottomSection,
      'bodyTotals': bodyTotals.map((i) => i.toJson()).toList(),
    };
  }
}

class BodyTotal {
  final String key;
  final String value;

  BodyTotal({
    required this.key,
    required this.value,
  });

  factory BodyTotal.fromJson(Map<String, dynamic> json) {
    return BodyTotal(
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
