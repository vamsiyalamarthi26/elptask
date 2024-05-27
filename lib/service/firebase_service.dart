import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payreport_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collection = FirebaseFirestore.instance.collection('employeeData');

  Future<void> addEmployeeData(EmployeeData data) async {
    try {
      await _collection.add(data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<EmployeeData>> getEmployeeData() async {
    try {
      QuerySnapshot querySnapshot = await _collection.get();
      return querySnapshot.docs
          .map((doc) => EmployeeData.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
