import 'package:hive_flutter/adapters.dart';
part 'menu_cart.g.dart';

@HiveType(typeId: 0)
class MenuCart extends HiveObject {
  @HiveField(0)
  int idMenu;

  @HiveField(1)
  int harga;

  @HiveField(2)
  int level;

  @HiveField(3)
  List<int> topping;

  @HiveField(4)
  int jumlah;

  @HiveField(5)
  String? catatan;

  @HiveField(6)
  String? foto;

  @HiveField(7)
  String? deskripsi;

  @HiveField(8)
  String nama;

  MenuCart({
    required this.idMenu,
    required this.harga,
    required this.level,
    required this.topping,
    required this.jumlah,
    required this.nama,
    this.catatan,
    this.deskripsi,
    this.foto,
  });
}
