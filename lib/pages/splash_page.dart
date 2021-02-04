import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'images/logo.jpeg',
        fit: BoxFit.contain,
      ),
    );
  }
}
