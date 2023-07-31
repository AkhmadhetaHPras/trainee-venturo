class PostOrder {
  int idUser;
  int? idVoucher;
  int potongan;
  int totalBayar;

  PostOrder({
    required this.idUser,
    this.idVoucher,
    required this.potongan,
    required this.totalBayar,
  });

  factory PostOrder.fromJson(Map<String, dynamic> json) {
    return PostOrder(
      idUser: json['id_user'],
      idVoucher: json['id_voucher'],
      potongan: json['potongan'],
      totalBayar: json['total_bayar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": idUser,
      "id_voucher": idVoucher,
      "potongan": potongan,
      "total_bayar": totalBayar,
    };
  }
}

class MenuModel {
  int idMenu;
  int harga;
  int? level;
  List<int> topping;
  int jumlah;
  String? catatan;

  MenuModel({
    required this.idMenu,
    required this.harga,
    this.level,
    required this.topping,
    required this.jumlah,
    required this.catatan,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      idMenu: json['id_menu'] ?? 0,
      harga: json['harga'] ?? 0,
      level: json['level'] ?? 0,
      topping: List<int>.from(json['topping'] ?? []),
      jumlah: json['jumlah'] ?? 0,
      catatan: json['catatan'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_menu": idMenu,
      "harga": harga,
      "level": level,
      "topping": topping,
      "jumlah": jumlah,
      "catatan": catatan,
    };
  }
}

class OrderDataModel {
  PostOrder order;
  List<MenuModel> menu;

  OrderDataModel({
    required this.order,
    required this.menu,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDataModel(
      order: PostOrder.fromJson(json['order'] ?? {}),
      menu: List<MenuModel>.from((json['menu'] as List<dynamic>? ?? [])
          .map((menu) => MenuModel.fromJson(menu))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order": order.toJson(),
      "menu": menu.map((m) => m.toJson()).toList(),
    };
  }
}
