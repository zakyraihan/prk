import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String status;
  String msg;
  User? user; // User can be nullable if the JSON might not contain it
  String role;
  String token;

  LoginModel({
    required this.status,
    required this.msg,
    required this.role,
    required this.token,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] ?? "", // Default to empty string if null
        msg: json["msg"] ?? "",
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        role: json["role"] ?? "",
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "user": user?.toJson(),
        "role": role,
        "token": token,
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;
  dynamic image;
  bool? emailVerified;
  String? status;
  dynamic noHp;
  dynamic notif;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
    this.image,
    this.emailVerified,
    this.status,
    this.noHp,
    this.notif,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] as int?,
        name: json["name"] as String?,
        email: json["email"] as String?,
        password: json["password"] as String?,
        role: json["role"] as String?,
        image: json["image"],
        emailVerified: json["email_verified"] as bool?,
        status: json["status"] as String?,
        noHp: json["no_hp"],
        notif: json["notif"],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
