import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';



import '../../Custom_widget.dart';
import 'Admindashboard.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _errorMessage;
  bool _obscureText = true;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ), // Navigate to Admin Dashboard
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        SizedBox.expand(
          // Expand to fill the Scaffold
          child: Lottie.asset(
            "assets/bg.json",
            fit: BoxFit.fill, // Fill the entire SizedBox
          ),
        ),
        SizedBox.expand(
          child: Container(
            color: bgcolor,
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoCard(),
              _buildLoginForm(),
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      height: 450,
      width: 300,
      decoration: BoxDecoration(color: darkbg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage("assets/logo.JPG"), fit: BoxFit.fill)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "IQ",
            style: GoogleFonts.abrilFatface(
                fontWeight: FontWeight.bold, fontSize: 30, color: mycolor3),
          ),
          const SizedBox(height: 16),
          Text(
            "IQ is a compact quiz application designed to test and improve knowledge across various topics. With multiple-choice questions and instant feedback, it offers a fun, interactive way to learn.",
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: mycolor3),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      height: 450,
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [darkbg, mycolor2]),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ADMIN LOGIN",
                style: GoogleFonts.abrilFatface(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: mycolor3),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // TextFormField(
              //   controller: _passwordController,
              //   obscureText: true,
              //   decoration: InputDecoration(
              //     hintText: "Password",
              //     hintStyle: TextStyle(color: Colors.grey.shade300),
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your password';
              //     }
              //     if (value.length < 6) {
              //       return 'Password must be at least 6 characters';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: mycolor1, // Customize icon color
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                  // ... your validation logic ...
                },
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              _isLoading
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: _login,
                      child: Container(
                        height: 50,
                        width: 200,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: mycolor3,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
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