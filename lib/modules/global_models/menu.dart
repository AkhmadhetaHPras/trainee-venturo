import 'package:hive_flutter/adapters.dart';
part 'menu.g.dart';

@HiveType(typeId: 0)
class Menu extends HiveObject {
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

  Menu({
    required this.idMenu,
    required this.harga,
    required this.level,
    required this.topping,
    required this.jumlah,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      idMenu: json['id_menu'],
      harga: json['harga'],
      level: json['level'],
      topping: List<int>.from(json['topping']),
      jumlah: json['jumlah'],
    );
  }
}
