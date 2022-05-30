// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

AiModel userModelFromJson(String str) => AiModel.fromJson(json.decode(str));

String userModelToJson(AiModel data) => json.encode(data.toJson());

class AiModel {
  final String age;
  final String gender;
  final String height;
  final String weight;
  final String ap_hi;
  final String ap_lo;
  final String cholesterol;
  final String gluc;
  final String smoke;
  final String alco;
  final String active;

  AiModel(
      {required this.age,
      required this.gender,
      required this.height,
      required this.weight,
      required this.ap_hi,
      required this.ap_lo,
      required this.cholesterol,
      required this.gluc,
      required this.smoke,
      required this.alco,
      required this.active});

  factory AiModel.fromJson(Map<String, dynamic> json) => AiModel(
        age: json["age"],
        gender: json["gender"],
        height: json["height"],
        weight: json["weight"],
        ap_hi: json["ap_hi"],
        ap_lo: json["ap_lo"],
        cholesterol: json["cholesterol"],
        gluc: json["gluc"],
        smoke: json["smoke"],
        alco: json["alco"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "age": age as int,
        "gender": gender as int,
        " height": height as int,
        "weight": weight as Float,
        "ap_hi": ap_hi as int,
        "ap_lo": ap_lo as int,
        "cholesterol": cholesterol as int,
        " gluc": gluc as int,
        " smoke": smoke as int,
        "alco": alco as int,
        " active": active as int,
      };
}
