import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:otaku_game/controllers/profile_controller.dart';
import 'package:otaku_game/widgets/appbars/appbar_widget.dart';
import 'package:otaku_game/widgets/home/menu_home_widget.dart';
import 'package:otaku_game/strings/ad_manager.dart';
import 'package:otaku_game/widgets/home/navigation_bar_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProfileController controller = ProfileController();

  @override
  void initState() {
    /*FirebaseAdMob.instance
        .initialize(appId: FirebaseAdMob.testAppId)
        .then((value) => AdManager().loadBannerAd());
    */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/naruto.jpg'),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FutureBuilder(
              future: controller.getPlayerData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none)
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                else {
                  final player = snapshot.data;

                  return Row(
                    children: [
                      appBar(context, player),
                      player == null
                          ? IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {});
                              },
                              tooltip: 'Recarregar',
                            )
                          : SizedBox.shrink(),
                    ],
                  );
                }
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: navigationBarHome(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: menuHome(context),
            ),
          ),
        ),
      ),
    );
  }
}
