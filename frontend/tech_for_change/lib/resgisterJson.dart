// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    String name;
    String email;
    String pass;

    Register({
        this.name,
        this.email,
        this.pass,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        name: json["name"],
        email: json["email"],
        pass: json["pass"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "pass": pass,
    };
}