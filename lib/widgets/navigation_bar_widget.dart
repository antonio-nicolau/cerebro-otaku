import 'package:flutter/material.dart';
import 'package:get/get.dart';

myNavigationBar(context, Color c, Color background) {
  return BottomNavigationBar(
    onTap: (index) {
      if (index == 0) {
        Get.back();
      }
    },
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
    backgroundColor: background,
    items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.arrow_back,
          size: 34,
          color: c,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.save,
            color: Colors.transparent,
          ),
          label: ''),
    ],
  );
}
