import 'dart:convert';

SiswaProfile siswaProfileFromJson(String str) =>
    SiswaProfile.fromJson(json.decode(str));

String siswaProfileToJson(SiswaProfile data) => json.encode(data.toJson());

class SiswaProfile {
  Siswa siswa;

  SiswaProfile({
    required this.siswa,
  });

  factory SiswaProfile.fromJson(Map<String, dynamic> json) => SiswaProfile(
        siswa: Siswa.fromJson(json["siswa"]),
      );

  Map<String, dynamic> toJson() => {
        "siswa": siswa.toJson(),
      };
}

class Siswa {
  int id;
  int userId;
  String namaSiswa;
  String nis;
  String nisn;
  dynamic nik;
  String tempatLahir;
  DateTime tanggalLahir;
  String alamat;
  String sekolahAsal;
  String jenisKelamin;
  int anakKe;
  DateTime tanggalDiterima;
  String angkatan;
  String tahunAjaran;
  String status;
  String keterangan;
  DateTime createdAt;
  DateTime updatedAt;

  Siswa({
    required this.id,
    required this.userId,
    required this.namaSiswa,
    required this.nis,
    required this.nisn,
    required this.nik,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamat,
    required this.sekolahAsal,
    required this.jenisKelamin,
    required this.anakKe,
    required this.tanggalDiterima,
    required this.angkatan,
    required this.tahunAjaran,
    required this.status,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        id: json["id"],
        userId: json["user_id"],
        namaSiswa: json["nama_siswa"],
        nis: json["nis"],
        nisn: json["nisn"],
        nik: json["nik"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        alamat: json["alamat"],
        sekolahAsal: json["sekolah_asal"],
        jenisKelamin: json["jenis_kelamin"],
        anakKe: json["anak_ke"],
        tanggalDiterima: DateTime.parse(json["tanggal_diterima"]),
        angkatan: json["angkatan"],
        tahunAjaran: json["tahun_ajaran"],
        status: json["status"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama_siswa": namaSiswa,
        "nis": nis,
        "nisn": nisn,
        "nik": nik,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir.toIso8601String(),
        "alamat": alamat,
        "sekolah_asal": sekolahAsal,
        "jenis_kelamin": jenisKelamin,
        "anak_ke": anakKe,
        "tanggal_diterima": tanggalDiterima.toIso8601String(),
        "angkatan": angkatan,
        "tahun_ajaran": tahunAjaran,
        "status": status,
        "keterangan": keterangan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
