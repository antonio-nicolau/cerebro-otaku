import 'dart:convert';

List<ShopeModel> shopeModelFromJson(String str) =>
    List<ShopeModel>.from(json.decode(str).map((x) => ShopeModel.fromJson(x)));

class ShopeModel {
  ShopeModel({
    this.id,
    this.name,
    this.quantite,
    this.pointNecessary,
  });

  int id;
  String name;
  int quantite;
  int pointNecessary;

  factory ShopeModel.fromJson(Map<String, dynamic> json) => ShopeModel(
        id: json["id"],
        name: json["nome"],
        quantite: json["quantidade"],
        pointNecessary: json["pontosNecessario"],
      );
}
