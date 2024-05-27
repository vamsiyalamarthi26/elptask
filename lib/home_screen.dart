import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String department = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          department = userDoc['department'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: Center(child: Text('Welcome!')),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          if (department == 'payroll') ...[
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Pay Reports',
              tooltip: 'Pay Reports',
            ),
          ],
          if (department == 'scheduling') ...[
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Schedule',
              tooltip: 'Schedule',
            ),
          ],
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            tooltip: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            tooltip: 'Settings',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              if (department == 'payroll') {
                Navigator.pushNamed(context, 'payroll');
              } else if (department == 'scheduling') {
                Navigator.pushNamed(context, 'scheduling');
              }
              break;
            case 1:
              if (department == 'payroll') {
                Navigator.pushNamed(context, 'chat');
              } else {
                Navigator.pushNamed(context, 'chat');
              }
              break;
            case 2:
              Navigator.pushNamed(context, 'settings');
              break;
          }
        },
      ),
    );
  }
}
