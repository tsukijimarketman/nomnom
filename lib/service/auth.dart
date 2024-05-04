import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final  FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentuser()async{
    return await auth.currentUser;
  }

  getCurrentUserEmail()async{
    return await auth.currentUser!.email;
  }

  Future SignOut()async{
    await FirebaseAuth .instance.signOut();
  }

  Future DeleteUser()async{
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}