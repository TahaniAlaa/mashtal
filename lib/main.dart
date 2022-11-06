import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantation/home.dart';
import 'package:plantation/signup.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'login.dart';
import 'splash_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    title: 'My Shop',debugShowCheckedModeBanner: false,
     theme: ThemeData(
     primarySwatch: Colors.grey,
     ),
     home:SplashScreen(),
     routes: {
     "cart":(context)=>Cart(),
     },

     );

  }
}


