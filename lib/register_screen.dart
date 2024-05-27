import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String userName = '';
  String userPhone = '';
  String dateOfBirth = '';
  String? profilePictureURL;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle picked image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
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
                    hintText: 'Enter your username',
                    icon: Icons.person,
                    onChanged: (value) {
                      userName = value;
                    },
                    obscureText: false,
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
                    hintText: 'Enter your phone number',
                    icon: Icons.phone,
                    onChanged: (value) {
                      userPhone = value;
                    },
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    hintText: 'Enter your date of birth',
                    icon: Icons.date_range,
                    onChanged: (value) {
                      dateOfBirth = value;
                    },
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upload Profile Picture'),
                      IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: _pickImage,
                      ),
                    ],
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
                    child: Text('Register'),
                    onPressed: () async {
                      if (email.isNotEmpty &&
                          password.isNotEmpty &&
                          userName.isNotEmpty &&
                          userPhone.isNotEmpty &&
                          dateOfBirth.isNotEmpty) {
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if (newUser != null) {
                            await FirebaseFirestore.instance.collection('users').doc(newUser.user!.uid).set({
                              'email': email,
                              'username': userName,
                              'phone': userPhone,
                              'dateOfBirth': dateOfBirth,
                              // Add other fields as needed
                            });
                            Navigator.pushNamed(context, 'login');
                          }
                        } catch (e) {
                          _showErrorDialog(context, e);
                          print(e);
                        }
                      } else {
                        _showErrorDialog(context, 'Please fill in all mandatory fields.');
                      }
                    },
                  ),
                  TextButton(
                    child: Text('Already existing user ?'
                        ' login here '),
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                  ),
                ],
              ),
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
}
