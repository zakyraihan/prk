import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mysmk_prakerin/model/login_model.dart';
import 'package:mysmk_prakerin/model/tugas_model.dart';
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
}
