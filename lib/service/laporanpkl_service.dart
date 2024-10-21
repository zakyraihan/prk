import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mysmk_prakerin/model/create_laporan_model.dart';
import 'package:mysmk_prakerin/model/detail_laporanpkl_model.dart';
import 'package:mysmk_prakerin/model/laporanpkl_model.dart';
import 'package:mysmk_prakerin/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanpklService {
  static const String _baseUrl =
      'https://backend-mysmk-dev.smkmadinatulquran.sch.id';

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
      log(response.body);
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

  // Future createLaporanPkl(
  //   String judulKegiatan,
  //   String isiLaporan,
  // ) async {
  //   try {
  //     final url = Uri.parse('$_baseUrl/santri/laporan-harian-pkl/create');

  //     Map<String, dynamic> data = {
  //       "judul_kegiatan": judulKegiatan,
  //       "isi_laporan": isiLaporan,
  //       "foto":
  //           "https://www.google.com/imgres?q=foto%20orang%20pkl&imgurl=https%3A%2F%2Fbsi.uad.ac.id%2Fwp-content%2Fuploads%2FPenerimaan-siswa-magang-SMKN-1-BANTUL-2-1.jpg",
  //       "longtitude": 70.05000000,
  //       "latitude": -50.80000000,
  //       "status": "hadir",
  //     };

  //     String body = json.encode(data);

  //     final prefs = await SharedPreferences.getInstance();
  //     String? dataLogin = prefs.getString('login');

  //     if (dataLogin == null || dataLogin.isEmpty) {
  //       log("Token not found.");
  //       return null;
  //     }

  //     LoginModel loginData = loginModelFromJson(dataLogin);
  //     String token = 'Bearer ${loginData.token}';

  //     final response = await http.post(
  //       url,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "X-Authorization": token,
  //       },
  //       body: body,
  //     );

  //     if (response.statusCode == 200) {
  //       log(response.body);
  //       LaporanPrakerin laporan =
  //           laporanPrakerinFromJson(response.body.toString());
  //       return laporan.data;
  //     } else {
  //       log('Failed to create laporan. Status code: ${response.statusCode}, ${response.body}');
  //       return false;
  //     }
  //   } catch (e) {
  //     log('Error creating laporan: $e');
  //     return null;
  //   }
  // }

  Future<LaporanUpdateResponse?> createLaporan(
      DataCreateLaporan laporan) async {
    final Uri url =
        Uri.parse('http://172.10.50.71:8085/santri/laporan-harian-pkl/create');

    final Map<String, dynamic> body = {
      "judul_kegiatan": laporan.judulKegiatan,
      "isi_laporan": laporan.isiLaporan,
      "foto": laporan.foto,
      "longtitude": laporan.longtitude,
      "latitude": laporan.latitude,
      "status": laporan.status,
      "student_id": laporan.studentId,
      "tanggal": laporan.tanggal?.toIso8601String(),
    };

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
      body: json.encode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return laporanUpdateResponseFromJson(response.body);
    } else {
      throw Exception('Failed to create laporan: ${response.reasonPhrase}');
    }
  }
}
