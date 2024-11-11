// To parse this JSON data, do
//
//     final tugas = tugasFromJson(jsonString);

import 'dart:convert';

Tugas tugasFromJson(String str) => Tugas.fromJson(json.decode(str));

String tugasToJson(Tugas data) => json.encode(data.toJson());

class Tugas {
    String status;
    String msg;
    String message;
    List<DataTugas> data;
    Pagination pagination;

    Tugas({
        required this.status,
        required this.msg,
        required this.message,
        required this.data,
        required this.pagination,
    });

    factory Tugas.fromJson(Map<String, dynamic> json) => Tugas(
        status: json["status"],
        msg: json["msg"],
        message: json["message"],
        data: List<DataTugas>.from(json["data"].map((x) => DataTugas.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class DataTugas {
    int id;
    String tugas;
    int teacherId;
    String linkSoal;
    DateTime batasWaktu;
    DateTime datumCreatedAt;
    DateTime datumUpdatedAt;
    DateTime tanggal;
    String deskripsiTugas;
    DateTime createdAt;
    DateTime updatedAt;
    Teacher teacher;

    DataTugas({
        required this.id,
        required this.tugas,
        required this.teacherId,
        required this.linkSoal,
        required this.batasWaktu,
        required this.datumCreatedAt,
        required this.datumUpdatedAt,
        required this.tanggal,
        required this.deskripsiTugas,
        required this.createdAt,
        required this.updatedAt,
        required this.teacher,
    });

    factory DataTugas.fromJson(Map<String, dynamic> json) => DataTugas(
        id: json["id"],
        tugas: json["tugas"],
        teacherId: json["teacher_id"],
        linkSoal: json["link_soal"],
        batasWaktu: DateTime.parse(json["batas_waktu"]),
        datumCreatedAt: DateTime.parse(json["created_at"]),
        datumUpdatedAt: DateTime.parse(json["updated_at"]),
        tanggal: DateTime.parse(json["tanggal"]),
        deskripsiTugas: json["deskripsi_tugas"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        teacher: Teacher.fromJson(json["teacher"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tugas": tugas,
        "teacher_id": teacherId,
        "link_soal": linkSoal,
        "batas_waktu": batasWaktu.toIso8601String(),
        "created_at": datumCreatedAt.toIso8601String(),
        "updated_at": datumUpdatedAt.toIso8601String(),
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "deskripsi_tugas": deskripsiTugas,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "teacher": teacher.toJson(),
    };
}

class Teacher {
    int id;
    int teacherUserId;
    String namaGuru;
    String status;
    dynamic keterangan;
    DateTime createdAt;
    DateTime updatedAt;
    int userId;

    Teacher({
        required this.id,
        required this.teacherUserId,
        required this.namaGuru,
        required this.status,
        required this.keterangan,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
    });

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        teacherUserId: json["user_id"],
        namaGuru: json["nama_guru"],
        status: json["status"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": teacherUserId,
        "nama_guru": namaGuru,
        "status": status,
        "keterangan": keterangan,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
    };
}

class Pagination {
    int total;

    Pagination({
        required this.total,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
    };
}
