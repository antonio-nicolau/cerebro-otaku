import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/controllers/registro_controller.dart';
import 'package:otaku_game/widgets/navigation_bar_widget.dart';

class RegistroPage extends StatefulWidget {
  bool update = false;
  int id;
  String name, password, cla;

  RegistroPage(bool update, int id, String name, String cla) {
    if (update) {
      this.update = update;
      this.id = id;
      this.name = name;
      this.cla = cla;
    }
  }

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  RegistroController _controller = RegistroController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _controller.getAllClas();

    if (widget.update) {
      _nameController.text = widget.name;
      _controller.claSelected = widget.cla;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/onepiece.jpg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar:
            myNavigationBar(context, Colors.white, Colors.transparent),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(child: containerItems(context)),
          ),
        ),
      ),
    );
  }

  Widget containerItems(context) {
    context = context;
    return GetBuilder<RegistroController>(
        init: _controller,
        builder: (_) {
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 15.0),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 90.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 90.0, 10.0, 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Cria uma conta ',
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
                            'E desfrute o jogo ao máximo ',
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Column(
                            children: [
                              _buildTextField('Nome', _nameController),
                              SizedBox(height: 15.0),
                              !widget.update
                                  ? _buildPasswordField(
                                      'Senha', _passwordController)
                                  : SizedBox.shrink(),
                              !widget.update
                                  ? SizedBox(height: 15.0)
                                  : SizedBox.shrink(),
                              _widgetCla(),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          _buildSaveButton(context),
                          SizedBox(height: 15.0),
                          _.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : SizedBox.shrink(),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 70,
                  child: GestureDetector(
                    onTap: () => _.chooseImageFromGalery(),
                    child: Stack(
                      children: [
                        _.image == null
                            ? Image(
                                image: AssetImage('images/person.png'),
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: _.image,
                              ),
                        Positioned(
                          right: 25,
                          bottom: 15,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildSaveButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width * (50 / 100),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: FlatButton(
        onPressed: () {
          final name = _nameController.text;
          final password = _passwordController.text;

          if (!widget.update)
            _controller.savePlayer(name, password);
          else {
            _controller.updatePlayer(widget.id, name, widget.name);
          }
        },
        child: Text(
          !widget.update ? 'Salvar' : 'Editar',
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
        controller: c,
        decoration: InputDecoration(
          labelText: _label,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
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
        enabled: widget.update ? false : true,
        controller: c,
        decoration: InputDecoration(
          labelText: _label,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        style: TextStyle(
            color: Colors.white, fontSize: 21.0, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }

  _widgetCla() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Teu clã',
            style: TextStyle(color: Colors.white60, fontSize: 18.0),
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: _controller.claSelected,
            icon: Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String value) {
              _controller.selectCla(value);
            },
            dropdownColor: Colors.black,
            items: _controller.allClas
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white, fontSize: 19.0),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
