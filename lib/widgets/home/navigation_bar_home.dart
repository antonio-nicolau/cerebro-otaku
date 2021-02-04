import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:otaku_game/pages/scores_page.dart';
import 'package:otaku_game/pages/shope_page.dart';

navigationBarHome() {
  return BottomNavigationBar(
    onTap: (index) {
      switch (index) {
        case 0:
          Get.to(ScoresPage());
          break;
        case 1:
          Get.to(ShopePage());
          break;
      }
    },
    selectedItemColor: Colors.black87,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    unselectedItemColor: Colors.black87,
    backgroundColor: Colors.transparent,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.score), label: 'SCORE'),
      BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'LOJA'),
    ],
  );
}
