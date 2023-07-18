class MenuResponse {
  final int? statusCode;
  final List<MenuData>? data;
  final List<String>? errors;

  MenuResponse({
    this.statusCode,
    this.data,
    this.errors,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    return MenuResponse(
      statusCode: json['status_code'],
      data: json['data'] != null
          ? List<MenuData>.from(
              json['data'].map((data) => MenuData.fromJson(data)))
          : null,
      errors: json['errors'] != null
          ? List<String>.from(json['errors'].map((error) => error.toString()))
          : null,
    );
  }
}

class MenuData {
  final int? idMenu;
  final String? nama;
  final String? kategori;
  final int? harga;
  final String? deskripsi;
  final String? foto;
  final int? status;

  MenuData({
    this.idMenu,
    this.nama,
    this.kategori,
    this.harga,
    this.deskripsi,
    this.foto,
    this.status,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) {
    return MenuData(
      idMenu: json['id_menu'],
      nama: json['nama'],
      kategori: json['kategori'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      foto: json['foto'],
      status: json['status'],
    );
  }
}
