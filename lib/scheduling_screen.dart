import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elp_task1/Scheduling/api_service.dart';
import 'package:elp_task1/chat_screen.dart';
import 'package:elp_task1/login_screen.dart';
import 'package:elp_task1/scheduling_calendar.dart';
import 'package:elp_task1/screens/Scheduling_upload_screen.dart';
import 'package:elp_task1/settings_screen.dart';
import 'package:elp_task1/views/userselectionscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SchedulingScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final User? user = _auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Text('Scheduling'),
          backgroundColor: Colors.lightBlueAccent,
        ),
     body: SchedulingCalendar(),
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
              title: Text('Scheduling'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulingUploadScreen(),
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
                    builder: (context) =>SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('logout'),
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
