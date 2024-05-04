import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/pages/botnav.dart';
import 'package:nomnom/pages/forgotpassword.dart';
import 'package:nomnom/pages/home.dart';
import 'package:nomnom/pages/signup.dart';
import 'package:nomnom/service/shared_pref.dart';
import 'package:nomnom/widget/widget_support.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formkey = GlobalKey<FormState>();
  String email = '', password = '';
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  // Update the fetchUserData method to return user data
  Future<Map<String, dynamic>> fetchUserData(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData;
      } else {
        print('No user data found for email: $email');
        return {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }

  userLogin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await fetchUserData(email);

      // Save user data to SharedPreferences upon successful login
      await SharedPreferenceHelper()
          .saveUserName(userCredential.user!.displayName ?? "");
      await SharedPreferenceHelper()
          .saveUserEmail(userCredential.user!.email ?? "");
      // You can save other user data if needed

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNav(email: email)),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "No user found",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          );
        });
      } else if (e.code == 'wrong-password') {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Wrong password",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFD61C38), Color(0xFFD61C38)])),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Text(""),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Image.asset(
                          'assets/logo.png',
                          width: MediaQuery.of(context).size.width / 2.3,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Login',
                                    style: AppWidget.HeadlineTextFieldStyle(),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: useremailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Email',
                                        hintStyle:
                                            AppWidget.semiboldTextFieldStyle(),
                                        prefixIcon: Icon(Icons.email_outlined)),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: userpasswordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            AppWidget.semiboldTextFieldStyle(),
                                        prefixIcon: Icon(Icons.lock_outlined)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  forgotPassword()));
                                    },
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "Forgot Password",
                                          style: AppWidget
                                              .semiboldTextFieldStyle(),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          email = useremailController.text;
                                          password =
                                              userpasswordController.text;
                                        });
                                      }
                                      userLogin();
                                    },
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20),
                                      elevation: 3,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        width: 200,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD61C38),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                            child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Don't have an account? Sign up here",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
