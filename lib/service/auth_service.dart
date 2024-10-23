import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mysmk_prakerin/model/login_gagal_model.dart';
import 'package:mysmk_prakerin/model/login_model.dart';
import 'package:mysmk_prakerin/model/profile_model.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl =
      'https://backend-mysmk-dev.smkmadinatulquran.sch.id';

  Future prosesLogin(String email, String password) async {
    Uri urlApi = Uri.parse("$_baseUrl/login");
    // ignore: avoid_print
    print(urlApi);

    Map data = {
      "email": email,
      "password": password,
      "loginAs": 9,
    };

    var body = json.encode(data);

    final response = await http.post(
      urlApi,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      print("Berhasil Login");
      try {
        DateTime tgl = DateTime.now();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("login", response.body.toString());
        preferences.setString("tanggalLogin", tgl.toString());

        print("data login saved");
      } catch (e) {
        print("gagal save login");
      }
      LoginModel data = loginModelFromJson(response.body.toString());
      return data;
    } else {
      print("Gagal Login");
      return loginGagalFromJson(response.body.toString()).msg;
    }
  }

  Future<bool> authMe({required BuildContext context}) async {
    Uri urlApi = Uri.parse("$_baseUrl/authme");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? dataLogin = preferences.getString('login');

    if (dataLogin == "" || dataLogin == null) {
      log("Token tidak ditemukan atau kosong");
      return false;
    }

    LoginModel data = loginModelFromJson(dataLogin);
    String token = "Bearer ${data.token}";

    final response = await http.get(
      urlApi,
      headers: {"X-Authorization": token},
    );

    if (response.statusCode == 200) {
      DateTime tgl = DateTime.now();
      preferences.setString("login", response.body.toString());
      preferences.setString("tanggalLogin", tgl.toString());
      log("Token diperbarui dan valid");
      return true;
    } else if (response.statusCode == 401) {
      // Token expired, arahkan ke login
      log("Token expired. Mengarahkan ke halaman login.");
      await preferences.clear();
      context.goNamed(Routes.login);
      return false;
    } else {
      log("Gagal Authme: ${response.body}");
      await preferences.clear();
      return false;
    }
  }

  Future getProfile() async {
    Uri url = Uri.parse('$_baseUrl/santri/profile');

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? dataLogin = preferences.getString('login');
    if (dataLogin == "" || dataLogin == null) {
      log("gagal get token");
      return [];
    }

    LoginModel data = loginModelFromJson(dataLogin);
    String token = "Bearer ${data.token}";

    final response = await http.get(
      url,
      headers: {
        "X-Authorization": token,
      },
    );

    if (response.statusCode == 200) {
      SiswaProfile data = siswaProfileFromJson(response.body);
      return data.siswa;
    } else {
      log("gagal notice");
      return [];
    }
  }
}
