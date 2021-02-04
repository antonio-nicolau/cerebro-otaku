import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:otaku_game/controllers/profile_controller.dart';
import 'package:otaku_game/pages/registro_page.dart';
import 'package:otaku_game/widgets/alerts/alert_logout.dart';
import 'package:otaku_game/widgets/alerts/alert_profile_image.dart';
import 'package:otaku_game/widgets/profile/logout_button_widget.dart';
import 'package:otaku_game/widgets/progressbar.dart';

class ProfilePage extends StatelessWidget {
  ProfileController controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/blackover.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0)
              Get.back();
            else if (index == 1) {
              final id = controller.player.id;
              final name = controller.player.name;
              final cla = controller.player.cla;

              Get.to(RegistroPage(true, id, name, cla));
            }
          },
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.arrow_back,
                  size: 34,
                  color: Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.edit,
                  size: 34,
                  color: Colors.white,
                ),
                label: ''),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: GetBuilder<ProfileController>(
                  init: controller,
                  initState: (_) {
                    controller.getPlayerData();
                  },
                  builder: (_) {
                    if (_.player == null) {
                      return progressBar('Carregando perfil...');
                    } else {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
                          padding: EdgeInsets.only(top: 30.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child:
                                    logoutButton(context, () => alertLogout()),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  '${_.player.image}',
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.shortestSide,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 35.0, vertical: 20.0),
                                child: Column(
                                  children: [
                                    _profileItem('Nome', _.player.name),
                                    _profileItem('Clã', _.player.cla),
                                    _profileItem('Nível', _.player.level),
                                    _profileItem(
                                        'Pontos', _.player.points.toString()),
                                    _profileItem(
                                        'vidas', _.player.life.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  })),
        ),
      ),
    );
  }

  _profileItem(String label, String value) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label',
            style: TextStyle(
                fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600),
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                '$value',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }
}
