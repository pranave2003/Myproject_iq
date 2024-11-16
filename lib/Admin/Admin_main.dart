import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'View/Admindashboard.dart';
import 'View/Adminlogin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Adminapp());
}

class Adminapp extends StatelessWidget {
  const Adminapp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AdminAuth_gate());
  }
}

class AdminAuth_gate extends StatefulWidget {
  const AdminAuth_gate({super.key});

  @override
  State<AdminAuth_gate> createState() => _AdminAuth_gateState();
}

class _AdminAuth_gateState extends State<AdminAuth_gate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if the user is authenticated
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          // If there is a user, navigate to the Dashboard, else show the login page
          if (user != null) {
            return DashboardScreen(); // Replace with your actual Dashboard widget
          } else {
            return Adminlogin(); // Replace with your login screen widget
          }
        }

        // Show a loading indicator while checking the auth state
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
