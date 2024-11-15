import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mysmk_prakerin/main_screen.dart';
import 'package:mysmk_prakerin/model/login_model.dart';
import 'package:mysmk_prakerin/model/tugas_model.dart';
import 'package:mysmk_prakerin/utils/alert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TugasService {
  final _baseUrl = dotenv.env['LOCAL_URL'];

  Future getTugas() async {
    final url = Uri.parse('$_baseUrl/santri/tugas-pkl/list');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataLogin = prefs.getString('login');
    if (dataLogin == '' || dataLogin == null) {
      log("gagal get token");
      return [];
    }

    LoginModel data = loginModelFromJson(dataLogin);
    String token = 'Bearer ${data.token}';

    final response = await http.get(
      url,
      headers: {
        "X-Authorization": token,
      },
    );

    if (response.statusCode == 200) {
      log(response.body);
      Tugas data = tugasFromJson(response.body);
      return data.data;
    } else {
      log('gagal ngambil');
      return [];
    }
  }

  Future createJawaban(
    String linkJawaban,
    String idTugas,
    BuildContext context,
  ) async {
    try {
      final url = Uri.parse('$_baseUrl/santri/jawaban-tugas-pkl/create');

      Map<String, dynamic> data = {
        "link_jawaban": linkJawaban,
        "tugas_pkl_id": idTugas,
      };

      String body = json.encode(data);

      final prefs = await SharedPreferences.getInstance();
      String? dataLogin = prefs.getString('login');

      if (dataLogin == null || dataLogin.isEmpty) {
        log("Token not found.");
        return null;
      }

      LoginModel loginData = loginModelFromJson(dataLogin);
      String token = 'Bearer ${loginData.token}';

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Authorization": token,
        },
        body: body,
      );

      final respondata = json.decode(response.body);

      if (response.statusCode == 200) {
        log(response.body);

        if (respondata['status'] == 'fail' && respondata['statusCode'] == 400) {
          showAlert(
            context,
            respondata['msg'],
            respondata['message'],
            AlertType.error,
          );
        } else {
          showAlert(
            context,
            respondata['msg'],
            respondata['message'],
            AlertType.success,
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                )),
          );
        }
      } else {
        log('Failed to create jawaban. Status code: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error creating jawaban: $e');
      return null;
    }
  }

  Future revisiJawaban(
    String linkJawaban,
    String idTugas,
    BuildContext context,
  ) async {
    try {
      final url =
          Uri.parse('$_baseUrl/santri/jawaban-tugas-pkl/update/$idTugas');

      Map<String, dynamic> data = {
        "link_jawaban": linkJawaban,
        "tugas_pkl_id": idTugas,
      };

      String body = json.encode(data);

      final prefs = await SharedPreferences.getInstance();
      String? dataLogin = prefs.getString('login');

      if (dataLogin == null || dataLogin.isEmpty) {
        log("Token not found.");
        return null;
      }

      LoginModel loginData = loginModelFromJson(dataLogin);
      String token = 'Bearer ${loginData.token}';

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Authorization": token,
        },
        body: body,
      );

      final respondata = json.decode(response.body);

      if (response.statusCode == 200) {
        log(response.body);

        if (respondata['status'] == 'fail' && respondata['statusCode'] == 400) {
          showAlert(
            context,
            respondata['msg'],
            respondata['message'],
            AlertType.error,
          );
        } else {
          showAlert(
            context,
            respondata['msg'],
            respondata['message'],
            AlertType.success,
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                )),
          );
        }
      } else {
        log('Failed to revisi jawaban. Status code: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error revisi jawaban: $e');
      return null;
    }
  }
}
