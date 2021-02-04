import 'package:flutter/material.dart';

progressBar(String message) {
  return Center(
      child: Column(
    children: [
      SizedBox(height: 50.0),
      CircularProgressIndicator(),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '$message',
        style: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      SizedBox(height: 50.0),
    ],
  ));
}
