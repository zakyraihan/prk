import 'dart:convert';

import 'package:mysmk_prakerin/model/profile_model.dart';

LaporanPrakerin laporanPrakerinFromJson(String str) =>
    LaporanPrakerin.fromJson(json.decode(str));

String laporanPrakerinToJson(LaporanPrakerin data) =>
    json.encode(data.toJson());

class LaporanPrakerin {
  String? status;
  String? msg;
  String? message;
  List<DataLaporann>? data;
  Pagination? pagination;

  LaporanPrakerin({
    this.status,
    this.msg,
    this.message,
    this.data,
    this.pagination,
  });

  factory LaporanPrakerin.fromJson(Map<String, dynamic> json) {
    return LaporanPrakerin(
      status: json["status"],
      msg: json["msg"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<DataLaporann>.from(
              json["data"].map((x) => DataLaporann.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "msg": msg,
      "message": message,
      "data":
          data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      "pagination": pagination?.toJson(),
    };
  }
}

class DataLaporann {
  int? id;
  String? judulKegiatan;
  String? isiLaporan;
  String? foto;
  bool isAbsen;
  String? longtitude;
  String? latitude;
  DateTime? tanggal;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? studentId;
  Siswa? siswa;
  List<LaporanDiniyyahHarian>? laporanDiniyyahHarian;

  DataLaporann({
    this.id,
    this.judulKegiatan,
    this.isiLaporan,
    this.foto,
    required this.isAbsen,
    this.longtitude,
    this.latitude,
    this.tanggal,
    this.createdAt,
    this.updatedAt,
    this.studentId,
    this.siswa,
    this.laporanDiniyyahHarian,
  });

  factory DataLaporann.fromJson(Map<String, dynamic> json) {
    return DataLaporann(
      id: json["id"],
      judulKegiatan: json["judul_kegiatan"],
      isiLaporan: json["isi_laporan"],
      foto: json["foto"],
      isAbsen: json["is_absen"],
      longtitude: json["longtitude"],
      latitude: json["latitude"],
      tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      studentId: json["student_id"],
      siswa: json["siswa"] == null ? null : Siswa.fromJson(json["siswa"]),
      laporanDiniyyahHarian: json["laporan_diniyyah_harian"] == null
          ? []
          : List<LaporanDiniyyahHarian>.from(json["laporan_diniyyah_harian"]
              .map((x) => LaporanDiniyyahHarian.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "judul_kegiatan": judulKegiatan,
      "isi_laporan": isiLaporan,
      "foto": foto,
      "is_absen": isAbsen,
      "longtitude": longtitude,
      "latitude": latitude,
      "tanggal": tanggal?.toIso8601String(),
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "student_id": studentId,
      "siswa": siswa?.toJson(),
      "laporan_diniyyah_harian": laporanDiniyyahHarian == null
          ? []
          : List<dynamic>.from(laporanDiniyyahHarian!.map((x) => x.toJson())),
    };
  }
}

class LaporanDiniyyahHarian {
  int? id;
  bool? dzikirPagi;
  dynamic dzikirPetang;
  dynamic sholatShubuh;
  dynamic sholatDzuhur;
  dynamic sholatAshar;
  dynamic sholatMagrib;
  dynamic sholatIsya;
  DateTime? tanggal;
  int? laporanHarianPklId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? studentId;

  LaporanDiniyyahHarian({
    this.id,
    this.dzikirPagi,
    this.dzikirPetang,
    this.sholatShubuh,
    this.sholatDzuhur,
    this.sholatAshar,
    this.sholatMagrib,
    this.sholatIsya,
    this.tanggal,
    this.laporanHarianPklId,
    this.createdAt,
    this.updatedAt,
    this.studentId,
  });

  factory LaporanDiniyyahHarian.fromJson(Map<String, dynamic> json) {
    return LaporanDiniyyahHarian(
      id: json["id"],
      dzikirPagi: json["dzikir_pagi"],
      dzikirPetang: json["dzikir_petang"],
      sholatShubuh: json["sholat_shubuh"],
      sholatDzuhur: json["sholat_dzuhur"],
      sholatAshar: json["sholat_ashar"],
      sholatMagrib: json["sholat_magrib"],
      sholatIsya: json["sholat_isya"],
      tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
      laporanHarianPklId: json["laporan_harian_pkl_id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      studentId: json["student_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "dzikir_pagi": dzikirPagi,
      "dzikir_petang": dzikirPetang,
      "sholat_shubuh": sholatShubuh,
      "sholat_dzuhur": sholatDzuhur,
      "sholat_ashar": sholatAshar,
      "sholat_magrib": sholatMagrib,
      "sholat_isya": sholatIsya,
      "tanggal": tanggal?.toIso8601String(),
      "laporan_harian_pkl_id": laporanHarianPklId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "student_id": studentId,
    };
  }
}

class Pagination {
  int? total;

  Pagination({this.total});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(total: json["total"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "total": total,
    };
  }
}
