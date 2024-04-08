import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nomnom/pages/details.dart';
import 'package:nomnom/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool burger = false, pasta = false, pizza = false, chicken = false, salad = false, drinks = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hello Gerick, ",style: AppWidget.boldTextFieldStyle()),
                        Container(
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.shopping_cart_outlined, color: Colors.white,
                          ),
                        )
                      ],
                    ),
                SizedBox(height: 30,),
                Text("Delight in every Bite",style: AppWidget.HeadlineTextFieldStyle()),
                Text("Your Doorstep Dining Experience",style: AppWidget.SoftTextFieldStyle()),
                SizedBox(height: 10,),
                Text("Categories", style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                showItem(),
                ],
                ),
              ),
              SizedBox(height: 5,),
              SingleChildScrollView(
                padding: EdgeInsets.all(20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(),));
                      },
                      child: SizedBox(
                        height: 250,
                        width: 210,
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 3,
                          child: Container(                
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  child: Image.asset('assets/burger.jpg',fit: BoxFit.cover,)),
                                Padding(
                                  padding: const EdgeInsets.only(left:13, right: 13, bottom: 13, top: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text("Krabby Patty", style: AppWidget.semiboldTextFieldStyle(),),
                                    Text("Made by spongebob", style: AppWidget.SoftTextFieldStyle(),),
                                    Text("₱99", style: AppWidget.PHP(),)]),
                                ),
                                ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    SizedBox(
                    height: 250,
                    width: 210,
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 3,
                      child: Container(                
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              child: Image.asset('assets/pasta.jpg',fit: BoxFit.cover,)),
                            Padding(
                              padding: const EdgeInsets.only(left:13, right: 13, bottom: 13, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text("Chupagetti", style: AppWidget.semiboldTextFieldStyle(),),
                                Text("Otenthick pasta", style: AppWidget.SoftTextFieldStyle(),),
                                Text("₱200", style: AppWidget.PHP(),)]),
                            ),
                            ],
                        ),
                      ),
                    ),
                  )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Food Items", style: TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
                child: Column(
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              child: Image.asset('assets/pasta.jpg', fit: BoxFit.cover, height: 120, width: 120,)),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("Chupagetti ni Jollibee", style: AppWidget.semiboldTextFieldStyle(),)),
                                  Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("Masarap 100%", style: AppWidget.SoftTextFieldStyle(),)),
                                  Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("₱200", style: AppWidget.PHP(),))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              child: Image.asset('assets/mussels.jpg', fit: BoxFit.cover, height: 120, width: 120,)),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("Tahong ni Carla", style: AppWidget.semiboldTextFieldStyle(),)),
                                  Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("Juicy, hindi fishy, wet malala", style: AppWidget.SoftTextFieldStyle(),)),
                                  Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("₱150", style: AppWidget.PHP(),))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              child: Image.asset('assets/burger.jpg', fit: BoxFit.cover, height: 120, width: 120,)),
                            SizedBox(width: 20,),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("Krabby Patty ni SpongeBob", style: AppWidget.semiboldTextFieldStyle(),)),
                                  Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("Made from Bikini Bottom", style: AppWidget.SoftTextFieldStyle(),)),
                                  Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text("₱99", style: AppWidget.PHP(),))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem(){
    return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(burger == false){
                      burger = true;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });}
                      else{
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });
                      }
                      
                    },
                    child: Material(
                      elevation: 5.0,
                      color: burger? Colors.grey:Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 50,
                        child: Center(
                          child: Text("Burger", style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                    ),
                  ),
                  SizedBox(width: 18,),
                  GestureDetector(
                    onTap: (){
                      if(pasta == false){
                      burger = false;
                      pasta = true;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });}
                      else{
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });
                      }
                    },
                    child: Material(
                      elevation: 5.0,
                      color: pasta? Colors.grey:Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 50,
                        child: Center(
                          child: Text("Pasta", style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                    ),
                  ),
                  SizedBox(width: 18,),
                  GestureDetector(
                    onTap: (){
                      if(pizza == false){
                      burger = false;
                      pasta = false;
                      pizza = true;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });}
                      else{
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });
                      }
                    },
                    child: Material(
                      elevation: 5.0,
                      color: pizza? Colors.grey:Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 50,
                        child: Center(
                          child: Text("Pizza", style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                    ),
                  ),
                  SizedBox(width: 18,),
                  GestureDetector(
                    onTap: (){
                      if(chicken == false){
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = true; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });}
                      else{
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });
                      }
                    },
                    child: Material(
                      elevation: 5.0,
                      color: chicken? Colors.grey:Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 50,
                        child: Center(
                          child: Text("Chicken", style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                    ),
                  ),
                  SizedBox(width: 18,),
                  GestureDetector(
                    onTap: (){
                      if(salad == false){
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = true;
                      drinks = false;
                      setState(() {
                        
                      });}
                      else{
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });
                      }
                    },
                    child: Material(
                      elevation: 5.0,
                      color: salad? Colors.grey:Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 50,
                        child: Center(
                          child: Text("Salad", style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                    ),
                  ),
                  SizedBox(width: 18,),
                  GestureDetector(
                    onTap: (){
                      if(drinks == false){
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = true;
                      setState(() {
                        
                      });}
                      else{
                      burger = false;
                      pasta = false;
                      pizza = false;
                      chicken = false; 
                      salad = false;
                      drinks = false;
                      setState(() {
                        
                      });
                      }
                    },
                    child: Material(
                      elevation: 10.0,
                      color: drinks? Colors.grey:Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 50,
                        child: Center(
                          child: Text("Drinks", style: TextStyle(color: Colors.white, fontSize: 16),),
                        )),
                    ),
                  ),
                ],
              ),
            );
  }
}