import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nomnom/admin/add_food.dart';
import 'package:nomnom/admin/admin_login.dart';
import 'package:nomnom/admin/home_admin.dart';
import 'package:nomnom/business/business.dart';
import 'package:nomnom/pages/splashscreen.dart';
import 'package:nomnom/rider/rider.dart';
import 'package:nomnom/rider/rider_dashboard.dart';
import 'package:nomnom/widget/app_constant.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nomnom/pages/botnav.dart';
import 'package:nomnom/pages/home.dart';
import 'package:nomnom/pages/login.dart';
import 'package:nomnom/pages/onboard.dart';
import 'package:nomnom/pages/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  _hideBar();
}
Future _hideBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BusinessLogin(), //Splash
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  
        title: Text(widget.title),
      ),
      body: Center(
      ),
       
    );
  }
}
