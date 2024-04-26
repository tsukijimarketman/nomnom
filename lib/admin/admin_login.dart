import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/admin/home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
                child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2),
                  padding: EdgeInsets.only(top: 45, left: 20, right: 20),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(
                              MediaQuery.of(context).size.width, 110))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Text(
                            "ADMIN PANEL",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Material(
                              elevation: 3,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 5, bottom: 5),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 160, 160, 147)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Username",
                                              hintStyle: TextStyle(color: Color.fromARGB(255, 160, 160, 147))),
                                          controller: userNameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter username";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 5, bottom: 5),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Password",
                                              hintStyle: TextStyle(color: Color.fromARGB(255, 160, 160, 147))),
                                          controller: passwordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter password";
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    GestureDetector(
                                      onTap: (){
                                        LoginAdmin();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        margin: EdgeInsets.symmetric(horizontal: 20),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                                        child: Center(child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),),),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
  LoginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if(result.data()['id']!=userNameController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your id is not correct",
                style: TextStyle(fontSize: 18),
              )));
        }
        else if(result.data()['password']!=passwordController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 18),
              )));
        }
        else{
          Route route = MaterialPageRoute(builder: (context)=>HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
