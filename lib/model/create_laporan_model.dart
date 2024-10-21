import 'dart:convert';

// Function to parse the JSON response string
LaporanUpdateResponse laporanUpdateResponseFromJson(String str) =>
    LaporanUpdateResponse.fromJson(json.decode(str));

// Function to convert the model to a JSON string
String laporanUpdateResponseToJson(LaporanUpdateResponse dataCreateLaporan) =>
    json.encode(dataCreateLaporan.toJson());

// Model class for the response
class LaporanUpdateResponse {
  String? status;
  String? msg;
  int? statusCode;
  String? message;
  DataCreateLaporan? dataCreateLaporan;

  LaporanUpdateResponse({
    this.status,
    this.msg,
    this.statusCode,
    this.message,
    this.dataCreateLaporan,
  });

  // Factory constructor for creating an instance from JSON
  factory LaporanUpdateResponse.fromJson(Map<String, dynamic> json) =>
      LaporanUpdateResponse(
        status: json["status"],
        msg: json["msg"],
        statusCode: json["statusCode"],
        message: json["message"],
        dataCreateLaporan: json["dataCreateLaporan"] == null
            ? null
            : DataCreateLaporan.fromJson(json["dataCreateLaporan"]),
      );

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "statusCode": statusCode,
        "message": message,
        "dataCreateLaporan": dataCreateLaporan?.toJson(),
      };
}

// Model class for the dataCreateLaporan field
class DataCreateLaporan {
  int? id;
  String? judulKegiatan;
  String? isiLaporan;
  String? foto;
  double? longtitude;
  double? latitude;
  String? status;
  int? studentId;
  DateTime? tanggal;
  DateTime? updatedAt;
  DateTime? createdAt;

  DataCreateLaporan({
    this.id,
    this.judulKegiatan,
    this.isiLaporan,
    this.foto,
    this.longtitude,
    this.latitude,
    this.status,
    this.studentId,
    this.tanggal,
    this.updatedAt,
    this.createdAt,
  });

  // Factory constructor for creating an instance from JSON
  factory DataCreateLaporan.fromJson(Map<String, dynamic> json) =>
      DataCreateLaporan(
        id: json["id"],
        judulKegiatan: json["judul_kegiatan"],
        isiLaporan: json["isi_laporan"],
        foto: json["foto"],
        longtitude: json["longtitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        status: json["status"],
        studentId: json["student_id"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  // Method to convert the dataCreateLaporan model to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "judul_kegiatan": judulKegiatan,
        "isi_laporan": isiLaporan,
        "foto": foto,
        "longtitude": longtitude,
        "latitude": latitude,
        "status": status,
        "student_id": studentId,
        "tanggal": tanggal?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
