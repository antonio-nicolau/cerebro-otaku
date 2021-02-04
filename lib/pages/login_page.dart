import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otaku_game/controllers/login_controller.dart';
import 'package:otaku_game/widgets/navigation_bar_widget.dart';

class LoginPage extends StatelessWidget {
  final _controller = LoginController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

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
        bottomNavigationBar:
            myNavigationBar(context, Colors.white, Colors.transparent),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: loginCard(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginCard(context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 90.0),
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.transparent,
            child: Card(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              child: Container(
                padding: EdgeInsets.only(top: 90.0, bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cérebro Otaku',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Faça o Login e começa a jogar',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15.0),
                    Column(
                      children: [
                        _buildTextField('Usuário', _nameController),
                        SizedBox(height: 15.0),
                        _buildPasswordField('Senha', _senhaController),
                        SizedBox(height: 30.0),
                        _buildButtons(context),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    GetBuilder<LoginController>(
                        init: _controller,
                        builder: (_) {
                          return Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Manter-me conectado',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17.0),
                                  ),
                                  Checkbox(
                                      value: _.keepConnect,
                                      onChanged: (value) =>
                                          _.changeKeepConnect(!_.keepConnect)),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              _.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : SizedBox.shrink(),
                            ],
                          );
                        }),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 65,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                image: AssetImage('images/blackover_perfil.jpeg'),
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtons(context) {
    return Container(
      width: MediaQuery.of(context).size.width * (50 / 100),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: FlatButton(
        onPressed: () =>
            _controller.login(_nameController.text, _senhaController.text),
        child: Text(
          'Entrar',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }

  _buildTextField(String _label, TextEditingController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        enableSuggestions: true,
        controller: c,
        validator: (value) => null,
        decoration: InputDecoration(
          labelText: _label,
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        style: TextStyle(
            color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildPasswordField(String _label, TextEditingController c) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        autocorrect: false,
        obscureText: true,
        enableSuggestions: false,
        controller: c,
        validator: (value) => null,
        decoration: InputDecoration(
          labelText: _label,
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        style: TextStyle(
            color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
