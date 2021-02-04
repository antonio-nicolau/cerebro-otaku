import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/pages/home_page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    ),
  );
}
