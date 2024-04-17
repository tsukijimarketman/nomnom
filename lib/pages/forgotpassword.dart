import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/pages/signup.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {

  TextEditingController mailcontroller = new TextEditingController();
  String email='';
  final _formkey = GlobalKey<FormState>();

  resetPassword()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password reset link has been sent to your email", style: TextStyle(fontSize: 18),)));
    }on FirebaseAuthException catch (e) {
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that email.", style: TextStyle(fontSize: 18),)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Container(
              alignment: Alignment.topCenter,
              child: Text("Password Recovery",
               style: TextStyle(
                color: Colors.white, 
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            Text("Enter your email", style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 30,),
            Expanded(child: Form(
              key: _formkey,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70, width: 2),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        padding: EdgeInsets.only(left:10),
                        child: TextFormField(
                          controller: mailcontroller,
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return 'Please enter email';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                            prefixIcon: Icon(Icons.person, color: Colors.white70, size: 30,),
                            border: InputBorder.none
                          ), 
                        ),),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){
                            if(_formkey.currentState!.validate()){
                              setState(() {
                                email=mailcontroller.text;
                              });
                              
                            resetPassword();
                            }
                          },
                          child: Container(
                            width: 140,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text("Send Email", style: TextStyle(color: Colors.black ,fontSize: 18, fontWeight: FontWeight.bold),),
                            ),),
                        ),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?\t", style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                        child: Text("Create here", style: TextStyle(color: Colors.yellowAccent, fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),))
                    ],
                  )
                    ],
                  ),))),
                  SizedBox(height: 50,),
                  
          ],
        ),
      ),
    );
  }
}