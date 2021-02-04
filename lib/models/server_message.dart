import 'dart:convert';

ServerResponse serverResponseFromJson(String str) =>
    ServerResponse.fromJson(json.decode(str));

String serverResponseToJson(ServerResponse data) => json.encode(data.toJson());

class ServerResponse {
  ServerResponse({
    this.ok = false,
    this.message,
    this.playerID,
  });

  bool ok = false;
  String message;
  int playerID;

  factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
        ok: json["res"],
        message: json["message"],
        playerID: json['idJogador'],
      );

  Map<String, dynamic> toJson() => {
        "res": ok,
        "message": message,
        "idJogador":playerID,
      };
}
