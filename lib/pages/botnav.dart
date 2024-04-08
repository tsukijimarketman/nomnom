import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nomnom/pages/home.dart';
import 'package:nomnom/pages/order.dart';
import 'package:nomnom/pages/profile.dart';
import 'package:nomnom/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int currentTabIndex = 0;
  late List<Widget> pages;
  late List<Widget> currentPage;
  late Home homepage;
  late Profile profile;
  late Wallet wallet;
  late Order order;

  @override
  void initState() {
    // TODO: implement initState
    homepage = Home();
    order = Order();
    profile = Profile();
    wallet = Wallet();

    pages = [homepage, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: Colors.black,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white,),
          Icon(Icons.shopping_bag_outlined, color: Colors.white,),
          Icon(Icons.wallet_outlined, color: Colors.white,),
          Icon(Icons.person_2_outlined, color: Colors.white,),
          ]),
          body: pages[currentTabIndex],
    );
  }
}