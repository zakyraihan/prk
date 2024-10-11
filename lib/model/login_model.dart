import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String status;
  String msg;
  User user;
  String role;
  String token;

  LoginModel({
    required this.status,
    required this.msg,
    required this.user,
    required this.role,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        msg: json["msg"],
        user: User.fromJson(json["user"]),
        role: json["role"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "user": user.toJson(),
        "role": role,
        "token": token,
      };
}

class User {
  int id;
  String name;
  String email;
  String password;
  String role;
  dynamic image;
  bool emailVerified;
  String status;
  dynamic noHp;
  dynamic notif;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.image,
    required this.emailVerified,
    required this.status,
    required this.noHp,
    required this.notif,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        image: json["image"],
        emailVerified: json["email_verified"],
        status: json["status"],
        noHp: json["no_hp"],
        notif: json["notif"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "image": image,
        "email_verified": emailVerified,
        "status": status,
        "no_hp": noHp,
        "notif": notif,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
