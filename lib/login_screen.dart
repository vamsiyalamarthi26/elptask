import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Main content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Image.asset(
                  'assets/images/splash.png',
                  height: 100,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  onChanged: (value) {
                    email = value;
                  },
                  obscureText: false,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  hintText: 'Enter your password',
                  icon: Icons.lock,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    try {
                      final userCredential = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      final user = userCredential.user;
                      if (user != null) {
                        _showDepartmentSelectionDialog(context, user.uid);
                      }
                    } catch (e) {
                      _showErrorDialog(context, e);
                      print(e);
                    }
                  },
                ),
                TextButton(
                  child: Text('Don\'t have an account? Register here.'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required ValueChanged<String> onChanged,
    required bool obscureText,
  }) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, Object e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(e.toString()),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showDepartmentSelectionDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Department'),
        content: Text('Please select your department:'),
        actions: <Widget>[
          TextButton(
            child: Text('Payroll'),
            onPressed: () {
              _selectDepartment(userId, 'payroll');
            },
          ),
          TextButton(
            child: Text('Scheduling'),
            onPressed: () {
              _selectDepartment(userId, 'scheduling');
            },
          ),
        ],
      ),
    );
  }

  void _selectDepartment(String userId, String department) {
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'department': department,
    }, SetOptions(merge: true)).then((_) {
      Navigator.of(context).pop();
      if (department == 'payroll') {
        Navigator.pushReplacementNamed(context, 'payroll');
      } else {
        Navigator.pushReplacementNamed(context, 'scheduling');
      }
    }).catchError((error) {
      print(error);
    });
  }
}
