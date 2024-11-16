import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myproject_iq/User/viewmodel/Auth.dart';
import 'package:myproject_iq/User/viewmodel/Domain,Location pvdr.dart';

import 'package:provider/provider.dart';

import '../firebase_options.dart';
import 'View/Register.dart';
import 'View/Userlogin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider<domainLocationprovider>(
          create: (_) => domainLocationprovider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 892),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: UserAuth_gate()),
      ),
    );
  }
}

class UserAuth_gate extends StatefulWidget {
  const UserAuth_gate({super.key});

  @override
  State<UserAuth_gate> createState() => _UserAuth_gateState();
}

class _UserAuth_gateState extends State<UserAuth_gate> {
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
            return Login();
          } else {
            return Login(); // Replace with your login screen widget
          }
        }

        // Show a loading indicator while checking the auth state
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
