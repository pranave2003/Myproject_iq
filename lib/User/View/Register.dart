import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../Custom_widget.dart';
import '../viewmodel/Auth.dart';
import '../viewmodel/Domain,Location pvdr.dart';
import 'Userlogin.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Email validation logic
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation logic
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Name field validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  // Reusable InputDecoration method
  InputDecoration _inputDecoration({
    required String labelText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      fillColor: mycolor3,
      filled: true,
      hintText: labelText,
      labelStyle: TextStyle(fontSize: 18.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tradeProvider = Provider.of<domainLocationprovider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up ",
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: mycolor3,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 50.h),

                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(fontSize: 18.sp, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: _validateName,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 20.h),

                  // Email Field with validation
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(fontSize: 18.sp, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.h),

                  // Password Field with eye icon to toggle visibility
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(fontSize: 18.sp, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 20.h),

                  // Trade Dropdown
                  StreamBuilder<List<String>>(
                    stream: tradeProvider.domainStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmerDropdown('Loading domain...');
                      } else if (snapshot.hasError) {
                        return Text("Error loading data");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _buildDropdown(
                          label: 'Select domain',
                          items: [],
                          onChanged: tradeProvider.selectTrade,
                        );
                      } else {
                        return _buildDropdown(
                          label: 'Select domain',
                          items: snapshot.data!,
                          value: tradeProvider.selectedTrade,
                          onChanged: tradeProvider.selectTrade,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Location Dropdown
                  StreamBuilder<List<String>>(
                    stream: tradeProvider.locationStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmerDropdown('Loading location...');
                      } else if (snapshot.hasError) {
                        return Text("Error loading data");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _buildDropdown(
                          label: 'Select location',
                          items: [],
                          onChanged: tradeProvider.selectLocation,
                        );
                      } else {
                        return _buildDropdown(
                          label: 'Select location',
                          items: snapshot.data!,
                          value: tradeProvider.selectedLocation,
                          onChanged: tradeProvider.selectLocation,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 60.h),

                  // Register Button
                  MyButton(
                    height: 50,
                    width: 200,
                    text: "Sign Up",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String? fcmToken =
                            await FirebaseMessaging.instance.getToken();
                        if (fcmToken != null) {
                          // If all fields are valid, proceed with registration
                          Provider.of<Auth>(context, listen: false)
                              .signUpWithCredentials(
                            context,
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                            tradeProvider.selectedTrade.toString(),
                            tradeProvider.selectedLocation.toString(),
                            fcmToken,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registering...')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error: No FCM Token')),
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Navigate to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildShimmerDropdown(String label) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label),
        items: [
          DropdownMenuItem(
            value: null,
            child: Text('Loading...'),
          ),
        ],
        onChanged: null,
      ),
    ),
  );
}

Widget _buildDropdown({
  required String label,
  required List<String> items,
  String? value,
  Widget? suffixIcon,
  required void Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      fillColor: mycolor3,
      filled: true,
      hintText: label,
      labelStyle: TextStyle(fontSize: 18.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffixIcon,
    ),
    items: items
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ),
        )
        .toList(),
    onChanged: onChanged,
  );
}
