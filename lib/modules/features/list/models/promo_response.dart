class PromoResponse {
  final int? statusCode;
  final List<PromoData>? data;
  final List<String>? errors;

  PromoResponse({
    this.statusCode,
    this.data,
    this.errors,
  });

  factory PromoResponse.fromJson(Map<String, dynamic> json) {
    return PromoResponse(
      statusCode: json['status_code'],
      data: json['data'] != null
          ? List<PromoData>.from(
              json['data'].map((data) => PromoData.fromJson(data)))
          : null,
      errors: json['errors'] != null
          ? List<String>.from(json['errors'].map((error) => error.toString()))
          : null,
    );
  }
}

class PromoData {
  final int? idPromo;
  final String? type;
  final String? nama;
  final int? diskon;
  final int? nominal;
  final int? kadaluarsa;
  final String? syaratKetentuan;
  final String? foto;

  PromoData({
    this.idPromo,
    this.type,
    this.nama,
    this.diskon,
    this.nominal,
    this.kadaluarsa,
    this.syaratKetentuan,
    this.foto,
  });

  factory PromoData.fromJson(Map<String, dynamic> json) {
    return PromoData(
      idPromo: json['id_promo'],
      type: json['type'],
      nama: json['nama'],
      diskon: json['diskon'],
      nominal: json['nominal'],
      kadaluarsa: json['kadaluarsa'],
      syaratKetentuan: json['syarat_ketentuan'],
      foto: json['foto'],
    );
  }
}
