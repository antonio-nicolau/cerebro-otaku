import 'package:flutter/material.dart';

logoutButton(context, Function f) {
    return Container(
      margin: EdgeInsets.only(right: 20.0, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: Icon(
          Icons.logout,
          size: 34,
          color: Colors.red,
        ),
        onPressed: () => f(),
      ),
    );
  }