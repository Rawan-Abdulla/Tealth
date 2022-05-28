import 'dart:convert';

Examination employeeModelJson(String str) =>
    Examination.fromJson(json.decode(str));

String employeeModelToJson(Examination data) => json.encode(data.toJson());

class Examination {
  String? eid;
  String? name;
  String? vlue;
  String? createdAt;

  Examination({this.eid, this.name, this.vlue, this.createdAt});

  // receiving data from server

  factory Examination.fromJson(Map<String, dynamic> json) => Examination(
      eid: json["eid"],
      name: json["name"],
      vlue: json["vlue"],
      createdAt: json["createdAt"]);

  Map<String, dynamic> toJson() => {
        "eid": eid,
        "name": name,
        "vlue": vlue,
        "createdAt": createdAt,
      };
}
