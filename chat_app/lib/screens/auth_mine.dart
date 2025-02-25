import 'package:chat_app/widgets/userImagePicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class authScreen extends StatefulWidget {
  const authScreen({super.key});
  // const authScreen();
  @override
  State<authScreen> createState() {
    // TODO: implement createState
    return _authScreenState();
  }
}

class _authScreenState extends State<authScreen> {
  var isLogin = true;
  final _form = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var username = '';
  bool _isAuthenticating = false;
  File? pickedImage;

  void onSubmit() async {
    // setState(() {
    //   _isAuthenticating = true;
    // });

    // await Future.delayed(const Duration(seconds: 4));
    // setState(() {
    //   _isAuthenticating = false;
    // });

    bool isValid = _form.currentState!.validate();

    if (!isValid || (!isLogin && pickedImage == null)) {
      //-- error
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      FirebaseAuth firebase = FirebaseAuth.instance;
      if (isLogin) {
        //Login User
        final userCredentials = await firebase.signInWithEmailAndPassword(
          email: this.email,
          password: this.password,
        );
      } else {
        // register user
        print('register user');

        final userCredentials = await firebase.createUserWithEmailAndPassword(
          email: this.email,
          password: this.password,
        );

        final storageRef =
            FirebaseStorage.instance.ref().child('user_images').child(
                  '${userCredentials.user!.uid}.jpg',
                );
        await storageRef.putFile(pickedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        print(imageUrl);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': this.username,
          'email': this.email,
          'image_Url': imageUrl,
        });
        // .then((value) => print("User Added"))
        // .catchError((error) => print("Failed to add user: $error"));
      }

      // await Future.delayed(const Duration(seconds: 4));
      // setState(() {
      //   _isAuthenticating = false;
      // });
      setState(() {
        _isAuthenticating = false;
      });
    } on FirebaseAuthException catch (error) {
      print('error : ${error.message}');
      print('error code : ${error.code}');
      if (error.code == 'email-already-in-use') {
        print('Email is already in use');
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    } finally {
      // setState(() {
      //   _isAuthenticating = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    var formContent = Column(
      children: [
        if (!isLogin)
          Userimagepicker(
            onPickImage: (selectedImage) {
              pickedImage = selectedImage;
            },
          ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email Address',
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          validator: (value) {
            if (value == null || value.isEmpty || !value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onSaved: (newValue) {
            email = newValue!;
          },
        ),
        if (!isLogin)
          TextFormField(
            decoration: const InputDecoration(labelText: "UserName"),
            enableSuggestions: false,
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().length < 4) {
                return 'Please enter a valid username';
              }
              return null;
            },
            onSaved: (newValue) {
              username = newValue!;
            },
          ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
          validator: (value) {
            print('value : $value');
            if (value == null || value.trim().length < 6) {
              return 'Password must be at least 6 characters or more';
            }
            return null;
          },
          onSaved: (newValue) {
            password = newValue!;
          },
        ),
        const SizedBox(height: 10),
        if (_isAuthenticating) const CircularProgressIndicator(),
        if (!_isAuthenticating)
          ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            child: Text(isLogin ? 'Login' : 'Sign Up'),
          ),
        if (!_isAuthenticating)
          TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text(isLogin
                ? 'Create an account'
                : 'I already have an account. Login'),
          )
      ],
    );

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   title: const Text('Title'),
      // ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: formContent,
                    ),
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
