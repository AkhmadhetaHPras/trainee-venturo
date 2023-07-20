import 'package:trainee/modules/features/menu/views/components/option_section.dart';

class DetailMenuResponse {
  int? statusCode;
  Data? data;
  List<dynamic>? errors;

  DetailMenuResponse({this.statusCode, this.data, this.errors});

  factory DetailMenuResponse.fromJson(Map<String, dynamic> json) {
    return DetailMenuResponse(
      statusCode: json['status_code'],
      data: Data.fromJson(json['data']),
      errors: json['errors'],
    );
  }
}

class Data {
  Menu? menu;
  List<Topping>? topping;
  List<Level>? level;

  Data({this.menu, this.topping, this.level});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      menu: Menu.fromJson(json['menu']),
      topping: (json['topping'] as List<dynamic>?)
          ?.map((item) => Topping.fromJson(item))
          .toList(),
      level: (json['level'] as List<dynamic>?)
          ?.map((item) => Level.fromJson(item))
          .toList(),
    );
  }
}

class Menu {
  int? idMenu;
  String? nama;
  String? kategori;
  int? harga;
  String? deskripsi;
  String? foto;
  int? status;

  Menu({
    this.idMenu,
    this.nama,
    this.kategori,
    this.harga,
    this.deskripsi,
    this.foto,
    this.status,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
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

class Topping extends CommonModel {
  @override
  int? idDetail;
  int? idMenu;
  @override
  String? keterangan;
  String? type;
  int? harga;

  Topping({
    this.idDetail,
    this.idMenu,
    this.keterangan,
    this.type,
    this.harga,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      idDetail: json['id_detail'],
      idMenu: json['id_menu'],
      keterangan: json['keterangan'],
      type: json['type'],
      harga: json['harga'],
    );
  }
}

class Level extends CommonModel {
  @override
  int? idDetail;
  int? idMenu;
  @override
  String? keterangan;
  String? type;
  int? harga;

  Level({
    this.idDetail,
    this.idMenu,
    this.keterangan,
    this.type,
    this.harga,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      idDetail: json['id_detail'],
      idMenu: json['id_menu'],
      keterangan: json['keterangan'],
      type: json['type'],
      harga: json['harga'],
    );
  }
}

abstract class CommonModel {
  String? get keterangan;
  int? get idDetail;
}
