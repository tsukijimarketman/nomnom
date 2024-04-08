import 'package:flutter/material.dart';
import 'package:nomnom/widget/widget_support.dart';
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                    Color(0xFFD61C38), Color(0xFFD61C38)
                  ])
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.8),
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )),
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                      Center(child: Image.asset(
                        'assets/logo.png', 
                        width: MediaQuery.of(context).size.width/5, 
                        fit: BoxFit.cover,)
                        ),
                        SizedBox(height: 50,),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Text('Login', style: AppWidget.HeadlineTextFieldStyle(),),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: AppWidget.semiboldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.email_outlined)
                                  ),
                                ),
                                SizedBox(height: 30,),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppWidget.semiboldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.lock_outlined)
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text("Forgot Password", style: AppWidget.semiboldTextFieldStyle(),)),
                                SizedBox(height: 80,),
                                Material(
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    width: 200,
                                    decoration: BoxDecoration(color: Color(0xFFD61C38), borderRadius: BorderRadius.circular(20)),
                                    child: Center(child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
