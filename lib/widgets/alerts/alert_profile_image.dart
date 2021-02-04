import 'package:flutter/material.dart';
import 'package:get/get.dart';

alertProfileImage(context, title, image) {
  Get.dialog(
    AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Image(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
