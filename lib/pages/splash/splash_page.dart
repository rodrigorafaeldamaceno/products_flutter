import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:products_flutter/pages/home/home_page.dart';
import 'package:products_flutter/pages/login/login_page.dart';
import 'package:products_flutter/stores/user_store.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLogged = false;

  @override
  void initState() {
    super.initState();

    UserStore().findOne()?.first?.then((value) {
      setState(() {
        isLogged = value != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Image.asset(
        'assets/dartside.png',
      ),
      splashIconSize: MediaQuery.of(context).size.width * 0.3,
      nextScreen: isLogged ? HomePage() : LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.grey[800],
    );
  }
}
