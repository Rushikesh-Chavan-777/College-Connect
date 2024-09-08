import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:r_connect/widgets/user_image_picker.dart';
import 'dart:io';

final _firebase = FirebaseAuth.instance;

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LoginPageScreenState();
  }
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredemailaddress = '';
  var _enteredpassword = '';
  var _enteredusername = '';
  var _enteredbio1 = '';
  var _enteredyearofgrad = '';
  File? selectedimage;
  var isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (_isLogin == false) {
      if (!isValid ||
          _isLogin && selectedimage == null ||
          selectedimage == null) {
        return;
      }
    }
    if(_isLogin == true){
      if (!isValid) {
        return;
      }
    }

    _form.currentState!.save();
    try {
      setState(() {
        isAuthenticating = true;
      });
      if (_isLogin) {
        final usercredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredemailaddress, password: _enteredpassword);
      } else {
        final usercredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredemailaddress, password: _enteredpassword);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${usercredentials.user!.uid}.jpg');
        await storageRef.putFile(selectedimage!);
        final imageurl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(usercredentials.user!.uid)
            .set({
          'email': _enteredemailaddress,
          'username': _enteredusername,
          'image_url': imageurl,
          'enteredbio1': _enteredbio1,
          'yearofgraduation': _enteredyearofgrad,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'likes': 0,
          'posts': 0,
          'user_posts': [],
          'post_captions': [],
          //'post_id': [],
          //'password' : _enteredpassword,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        //......
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')));
      setState(() {
        isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome to College Connect",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[400],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Login Text
              Text(
                _isLogin ? 'LOGIN TO CONNECT' : 'SIGNUP TO CONNECT',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              //image picker display for signup only
              if (!_isLogin)
                UserImagePicker(
                  onpickimage: (pickedimage) {
                    selectedimage = pickedimage;
                  },
                ),
              //start of form
              Form(
                key: _form,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Text field for email address
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.email),
                              Text("Your IIT H email"),
                            ],
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.trim().contains('iith.ac.in') ||
                              !value.trim().contains('@')) {
                            return 'Please enter a valid IIT-H email address only!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        onSaved: (value) {
                          _enteredemailaddress = value!;
                        },
                      ),
                      //text field for username
                      if (!_isLogin)
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.person),
                                Text("username"),
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredusername = value!;
                          },
                        ),
                      //textfield for bio_1
                      if (!_isLogin)
                        TextFormField(
                          maxLength: 30,
                          decoration: const InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.person),
                                Text("Your Bio(Somethin about yourself)"),
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a valid bio';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredbio1 = value!;
                          },
                        ),
                      //Text field for passing year
                      if (!_isLogin)
                        TextFormField(
                          keyboardType: TextInputType.number, //*changed*
                          maxLength: 30,
                          decoration: const InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.person),
                                Text("Year of graduation"),
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.trim().contains('20')) {
                              return 'Please enter a valid year of graduation only!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredyearofgrad = value!;
                          },
                        ),
                      //Text field for password
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Row(
                            children: [
                              Icon(Icons.password),
                              Text("Password"),
                            ],
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 6) {
                            return 'Please enter a password with atleast 6 characters!';
                          }
                          return null;
                        },
                        obscureText: true,
                        onSaved: (value) {
                          _enteredpassword = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      if (isAuthenticating) const CircularProgressIndicator(),
                      if (!isAuthenticating)
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text(_isLogin ? 'Login' : 'SignUp'),
                        ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create an account'
                            : 'I already have an account'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
