import 'package:flutter/material.dart';
import 'package:xo_game/XO_Game.dart';
  class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
     Future.delayed(const Duration(seconds: 3), () {
       Navigator.push(context, MaterialPageRoute(builder: (_) => const XOGame()));
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Image.network("https://i.pinimg.com/564x/22/5d/83/225d83e0db0ffd0e84d1424a75846dd9.jpg"),
// CircularProgressIndicator(color: Colors.gold,),
        ],
      )
    );
  }
}
