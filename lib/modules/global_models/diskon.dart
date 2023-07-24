class Diskon {
  int? statusCode;
  List<DiskonData>? data;
  List<String>? errors;

  Diskon({
    this.statusCode,
    this.data,
    this.errors,
  });

  factory Diskon.fromJson(Map<String, dynamic> json) {
    return Diskon(
      statusCode: json['status_code'],
      data: json['data'] != null
          ? List<DiskonData>.from(
              json['data'].map((data) => DiskonData.fromJson(data)))
          : null,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
    );
  }
}

class DiskonData {
  int? idDiskon;
  int? idUser;
  String? namaUser;
  String? nama;
  int? diskon;

  DiskonData({
    this.idDiskon,
    this.idUser,
    this.namaUser,
    this.nama,
    this.diskon,
  });

  factory DiskonData.fromJson(Map<String, dynamic> json) {
    return DiskonData(
      idDiskon: json['id_diskon'],
      idUser: json['id_user'],
      namaUser: json['nama_user'],
      nama: json['nama'],
      diskon: json['diskon'],
    );
  }
}
