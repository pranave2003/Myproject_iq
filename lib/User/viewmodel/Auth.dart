import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  User? get user => _user;

  // Constructor to check if a user is already logged in
  Auth() {
    _user = _auth.currentUser;
  }

  Future<void> signUpWithCredentials(
      BuildContext context,
      String name,
      String email,
      String password,
      String selectedTrade,
      String selectedLocation,
      String Fcmtoken) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = credential.user;

      await FirebaseFirestore.instance
          .collection('My Students')
          .doc(_user!.uid)
          .set({
        "name": name,
        "email": email,
        "fcmtoken": Fcmtoken,
        "ban": 0,
        "imageUrl":
            "https://static.vecteezy.com/system/resources/thumbnails/005/544/718/small_2x/profile-icon-design-free-vector.jpg",
        "userId": _user!.uid,
        "Trade": selectedTrade,
        "OfficeLocation": selectedLocation,
        'timestamp': FieldValue.serverTimestamp(),
        "Linkdin": "",
        "github": ""
      });

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Login()));
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showSnackbar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        _showSnackbar(context, "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to store data in SharedPreferences when using Email/Password login

  final _firestore = FirebaseFirestore.instance;
  String email = '', password = '';

  Future<void> _loginUser() async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      // Update FCM token in Firestore
      await _firestore
          .collection('Fcm_users')
          .doc(userCredential.user!.uid)
          .update({
        'fcmToken': fcmToken,
      });

      // Navigate to Home Page
    } catch (e) {
      print("Login Error: $e");
    }
  }

  Future<void> resetPassword(BuildContext context,
      {required String email}) async {
    if (email.isNotEmpty) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset link sent to $email')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        print("Password Reset Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Unable to send reset link')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address')),
      );
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
