// To parse this JSON data, do
//
//     final detailLaporanPrakerin = detailLaporanPrakerinFromJson(jsonString);

import 'dart:convert';

DetailLaporanPrakerin detailLaporanPrakerinFromJson(String str) => DetailLaporanPrakerin.fromJson(json.decode(str));

String detailLaporanPrakerinToJson(DetailLaporanPrakerin data) => json.encode(data.toJson());

class DetailLaporanPrakerin {
    String status;
    String msg;
    String message;
    Data data;

    DetailLaporanPrakerin({
        required this.status,
        required this.msg,
        required this.message,
        required this.data,
    });

    factory DetailLaporanPrakerin.fromJson(Map<String, dynamic> json) => DetailLaporanPrakerin(
        status: json["status"],
        msg: json["msg"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String judulKegiatan;
    String isiLaporan;
    String foto;
    bool isAbsen;
    String longtitude;
    String latitude;
    DateTime tanggal;
    DateTime dataCreatedAt;
    DateTime dataUpdatedAt;
    DateTime createdAt;
    DateTime updatedAt;
    int studentId;
    Siswa siswa;
    List<LaporanDiniyyahHarian> laporanDiniyyahHarian;

    Data({
        required this.id,
        required this.judulKegiatan,
        required this.isiLaporan,
        required this.foto,
        required this.isAbsen,
        required this.longtitude,
        required this.latitude,
        required this.tanggal,
        required this.dataCreatedAt,
        required this.dataUpdatedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.studentId,
        required this.siswa,
        required this.laporanDiniyyahHarian,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        judulKegiatan: json["judul_kegiatan"],
        isiLaporan: json["isi_laporan"],
        foto: json["foto"],
        isAbsen: json["is_absen"],
        longtitude: json["longtitude"],
        latitude: json["latitude"],
        tanggal: DateTime.parse(json["tanggal"]),
        dataCreatedAt: DateTime.parse(json["created_at"]),
        dataUpdatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentId: json["student_id"],
        siswa: Siswa.fromJson(json["siswa"]),
        laporanDiniyyahHarian: List<LaporanDiniyyahHarian>.from(json["laporan_diniyyah_harian"].map((x) => LaporanDiniyyahHarian.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul_kegiatan": judulKegiatan,
        "isi_laporan": isiLaporan,
        "foto": foto,
        "is_absen": isAbsen,
        "longtitude": longtitude,
        "latitude": latitude,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "created_at": dataCreatedAt.toIso8601String(),
        "updated_at": dataUpdatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student_id": studentId,
        "siswa": siswa.toJson(),
        "laporan_diniyyah_harian": List<dynamic>.from(laporanDiniyyahHarian.map((x) => x.toJson())),
    };
}

class LaporanDiniyyahHarian {
    int id;
    bool dzikirPagi;
    dynamic dzikirPetang;
    dynamic sholatShubuh;
    dynamic sholatDzuhur;
    dynamic sholatAshar;
    dynamic sholatMagrib;
    dynamic sholatIsya;
    DateTime tanggal;
    int laporanHarianPklId;
    DateTime laporanDiniyyahHarianCreatedAt;
    DateTime laporanDiniyyahHarianUpdatedAt;
    DateTime createdAt;
    DateTime updatedAt;
    int studentId;

    LaporanDiniyyahHarian({
        required this.id,
        required this.dzikirPagi,
        required this.dzikirPetang,
        required this.sholatShubuh,
        required this.sholatDzuhur,
        required this.sholatAshar,
        required this.sholatMagrib,
        required this.sholatIsya,
        required this.tanggal,
        required this.laporanHarianPklId,
        required this.laporanDiniyyahHarianCreatedAt,
        required this.laporanDiniyyahHarianUpdatedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.studentId,
    });

    factory LaporanDiniyyahHarian.fromJson(Map<String, dynamic> json) => LaporanDiniyyahHarian(
        id: json["id"],
        dzikirPagi: json["dzikir_pagi"],
        dzikirPetang: json["dzikir_petang"],
        sholatShubuh: json["sholat_shubuh"],
        sholatDzuhur: json["sholat_dzuhur"],
        sholatAshar: json["sholat_ashar"],
        sholatMagrib: json["sholat_magrib"],
        sholatIsya: json["sholat_isya"],
        tanggal: DateTime.parse(json["tanggal"]),
        laporanHarianPklId: json["laporan_harian_pkl_id"],
        laporanDiniyyahHarianCreatedAt: DateTime.parse(json["created_at"]),
        laporanDiniyyahHarianUpdatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentId: json["student_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dzikir_pagi": dzikirPagi,
        "dzikir_petang": dzikirPetang,
        "sholat_shubuh": sholatShubuh,
        "sholat_dzuhur": sholatDzuhur,
        "sholat_ashar": sholatAshar,
        "sholat_magrib": sholatMagrib,
        "sholat_isya": sholatIsya,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "laporan_harian_pkl_id": laporanHarianPklId,
        "created_at": laporanDiniyyahHarianCreatedAt.toIso8601String(),
        "updated_at": laporanDiniyyahHarianUpdatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student_id": studentId,
    };
}

class Siswa {
    int id;
    String namaSiswa;

    Siswa({
        required this.id,
        required this.namaSiswa,
    });

    factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        id: json["id"],
        namaSiswa: json["nama_siswa"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_siswa": namaSiswa,
    };
}
