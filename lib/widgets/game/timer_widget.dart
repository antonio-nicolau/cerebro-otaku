import 'package:flutter/material.dart';

timeWidget(int count) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        "$count",
        style: TextStyle(
          color: count < 20 ? Colors.white : Colors.red,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
