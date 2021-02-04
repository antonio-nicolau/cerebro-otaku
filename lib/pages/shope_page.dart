import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/controllers/profile_controller.dart';
import 'package:otaku_game/controllers/shope_controller.dart';
import 'package:otaku_game/models/shope_model.dart';
import 'package:otaku_game/widgets/navigation_bar_widget.dart';
import 'package:otaku_game/widgets/progressbar.dart';
import 'package:otaku_game/widgets/refresh_page_widget.dart';

class ShopePage extends StatelessWidget {
  ShopeController controller = new ShopeController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/blackover.jpg'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          bottomNavigationBar:
              myNavigationBar(context, Colors.white, Colors.transparent),
          backgroundColor: Colors.transparent,
          body: GetBuilder<ShopeController>(
            initState: (_) => {controller.getData()},
            init: controller,
            builder: (_) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: controller.noLogin
                      ? Container(
                          height: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(
                            'Faça Login primeiro',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : controller.shopeItens == null && !_.hasError
                          ? progressBar('Carregando a loja...')
                          : controller.hasError
                              ? refreshPageWidg(context, () {
                                  controller.hasError = false;
                                  controller.update();
                                  controller.getData();
                                })
                              : Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10.0, bottom: 30.0),
                                    padding: EdgeInsets.only(top: 30.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            padding: EdgeInsets.all(15.0),
                                            color: Colors.amber,
                                            child: Icon(
                                              Icons.shopping_cart,
                                              size: 90,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .shortestSide,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 35.0,
                                                vertical: 20.0),
                                            child: ListView.builder(
                                              itemCount:
                                                  controller.shopeItens.length,
                                              itemBuilder: (context, index) {
                                                ShopeModel item = controller
                                                    .shopeItens[index];

                                                return GestureDetector(
                                                  onTap: () => controller
                                                      .addPlayerItem(item),
                                                  child: shopeItemWidget(item),
                                                );
                                              },
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                ),
              );
            },
          ),
        ));
  }
}

shopeItemWidget(ShopeModel item) {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.name}',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '${item.quantite}',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            '${item.pointNecessary}',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
