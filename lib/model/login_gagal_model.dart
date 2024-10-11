import 'dart:convert';

LoginGagal loginGagalFromJson(String str) =>
    LoginGagal.fromJson(json.decode(str));

String loginGagalToJson(LoginGagal data) => json.encode(data.toJson());

class LoginGagal {
  String status;
  String msg;

  LoginGagal({
    required this.status,
    required this.msg,
  });

  factory LoginGagal.fromJson(Map<String, dynamic> json) => LoginGagal(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
