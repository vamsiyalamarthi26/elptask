import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elp_task1/screens/payreport_final.dart';
import 'package:elp_task1/settings_screen.dart';
import 'package:elp_task1/views/userselectionscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'PayReportsScreen.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

class PayrollScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Reports'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: PayReportFinal(),
      ),
      drawer: Drawer(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userData['username'] ?? 'Test'),
                  accountEmail: Text(user?.email ?? 'Test@gmail.com'),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage:  AssetImage('assets/images/profile.jpg'),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: AssetImage('assets/images/background2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text('Pay Reports'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayReportsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chat),
                  title: Text('Chat'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserSelectionScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
