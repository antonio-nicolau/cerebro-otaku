import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:otaku_game/pages/profile_page.dart';

appBar(context, player) {
  return player == null
      ? SizedBox.shrink()
      : Container(
          padding: EdgeInsets.only(left: 8.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 36,
                        ),
                      ),
                      Positioned(
                        top: 7,
                        right: 10,
                        child: Text(
                          "${player.life}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.green,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    child: Text(
                      '${player.points}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Get.to(ProfilePage()),
                child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: player.image != null
                            ? Image.network(
                                "${player.image}",
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'images/perfil_anime.jpg',
                                  fit: BoxFit.fill,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : Image.asset(
                                'images/perfil_anime.jpg',
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              ),
                      ),
                    )),
              ),
            ],
          ),
        );
}
