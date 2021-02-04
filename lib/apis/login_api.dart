import 'package:dio/dio.dart';
import 'package:otaku_game/models/server_message.dart';
import 'package:otaku_game/configuration.dart';

class LoginApi{
  Future<ServerResponse> makeLogin(String name,String password)async{
    final params = {'user':name,'senha':password};

    try{
      final response = await Dio().post(loginUrl,data: params);
      if(response != null && response.statusCode == 200){
        return serverResponseFromJson(response.data);
      }else
        return ServerResponse(ok: false,message:"Não foi possível fazer o Login, verifica a sua conexão");
    }
    catch(e){
      print(e);
    }
    return null;
  }
}