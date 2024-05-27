import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../chat_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User'),
      ),
      body: FutureBuilder<List<String>>(
        future: getUserEmails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching user emails'));
          } else {
            final userEmails = snapshot.data!;
            return ListView.builder(
              itemCount: userEmails.length,
              itemBuilder: (context, index) {
                final userEmail = userEmails[index];
                return ListTile(
                  title: Text(userEmail),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getUserEmails() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection('users').get();

      List<String> userEmails = querySnapshot.docs
          .map((doc) => doc.data()['email'])
          .where((email) => email != null)
          .map((email) => email as String)
          .toList();

      return userEmails;
    } catch (e) {
      print('Error getting user emails: $e');
      return [];
    }
  }
}
