import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mysmk_prakerin/model/detail_laporanpkl_model.dart';
import 'package:mysmk_prakerin/model/laporanpkl_model.dart';
import 'package:mysmk_prakerin/model/login_model.dart';
import 'package:mysmk_prakerin/screen/laporan_screen.dart';
import 'package:mysmk_prakerin/utils/alert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanpklService {
  final _baseUrl = dotenv.env['LOCAL_URL'];
  // 'https://backend-mysmk-dev.smkmadinatulquran.sch.id';

  Future getLaporanPkl() async {
    final url = Uri.parse('$_baseUrl/santri/laporan-harian-pkl/list');

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
      // log(response.body);
      LaporanPrakerin data = laporanPrakerinFromJson(response.body);
      return data.data;
    } else {
      log('gagal ngambil');
      return [];
    }
  }

  Future getLaporanDetailPkl(String id) async {
    final url = Uri.parse('$_baseUrl/santri/laporan-harian-pkl/detail/$id');

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
      DetailLaporanPrakerin data = detailLaporanPrakerinFromJson(response.body);

      return data.data;
    } else {
      log('gagal ngambil');
      return [];
    }
  }

  Future createLaporanPkl(
    String judulKegiatan,
    String isiLaporan,
    BuildContext context,
  ) async {
    try {
      final url = Uri.parse('$_baseUrl/santri/laporan-harian-pkl/create');

      Map<String, dynamic> data = {
        "judul_kegiatan": judulKegiatan,
        "isi_laporan": isiLaporan,
        "foto":
            "https://www.google.com/imgres?q=foto%20orang%20pkl&imgurl=https%3A%2F%2Fbsi.uad.ac.id%2Fwp-content%2Fuploads%2FPenerimaan-siswa-magang-SMKN-1-BANTUL-2-1.jpg",
        "longtitude": 70.05000000,
        "latitude": -50.80000000,
        "status": "hadir",
        "is_absen": true,
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
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LaporanWidget())),
          );
        } else {
          showAlert(
            context,
            respondata['msg'],
            respondata['message'],
            AlertType.success,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LaporanWidget(),
            )),
          );

          LaporanPrakerin laporan =
              laporanPrakerinFromJson(response.body.toString());
          return laporan.data;
        }
      } else {
        log('Failed to create laporan. Status code: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error creating laporan: $e');
      return null;
    }
  }

  // Future createLaporan(BuildContext context, DataCreateLaporan laporan) async {
  //   final Uri url = Uri.parse('$_baseUrl/santri/laporan-harian-pkl/create');

  //   final Map<String, dynamic> body = {
  //     "judul_kegiatan": laporan.judulKegiatan,
  //     "isi_laporan": laporan.isiLaporan,
  //     "foto": "laporan.foto",
  //     "longtitude": laporan.longtitude,
  //     "latitude": laporan.latitude,
  //     "status": laporan.status,
  //     "is_absen": laporan.isAbsen,
  //     "tanggal": laporan.tanggal?.toIso8601String(),
  //   };

  //   final prefs = await SharedPreferences.getInstance();
  //   String? dataLogin = prefs.getString('login');

  //   if (dataLogin == null || dataLogin.isEmpty) {
  //     log("Token not found.");
  //     return null;
  //   }

  //   LoginModel loginData = loginModelFromJson(dataLogin);
  //   String token = 'Bearer ${loginData.token}';

  //   final response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "X-Authorization": token,
  //     },
  //     body: jsonEncode(body),
  //   );

  //   final respondata = jsonDecode(response.body);

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     if (respondata['status'] == 'fail' && respondata['statusCode'] == 400) {
  //       showAlert(
  //         context,
  //         respondata['msg'],
  //         respondata['message'],
  //         AlertType.error,
  //         onPressed: () => context.pop(),
  //       );
  //     } else {
  //       showAlert(
  //         context,
  //         respondata['msg'],
  //         respondata['message'],
  //         AlertType.success,
  //         onPressed: () => context.pushReplacementNamed(Routes.main),
  //       );

  //       return laporanUpdateResponseFromJson(response.body);
  //     }
  //   }

  //   return null;
  // }
}
