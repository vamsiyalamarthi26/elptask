import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _user != null ? _buildUserProfile() : _buildNoUser(),
    );
  }

  Widget _buildUserProfile() {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(_user!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching user data'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('User data not found'));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: userData['profilePictureURL'] != null
                    ? NetworkImage(userData['profilePictureURL'])
                    : null,
                child: userData['profilePictureURL'] == null
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
              SizedBox(height: 16),
              Text('Name: ${userData['username'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${_user!.email ?? 'N/A'}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Phone: ${userData['phone'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Date of Birth: ${userData['dateOfBirth'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {



                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNoUser() {
    return Center(child: Text('No user logged in'));
  }
}
