class Order {
  int idOrder;
  String noStruk;
  String nama;
  int totalBayar;
  String tanggal;
  int status;
  List<Menu> menu;

  Order({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.menu,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Menu> menuList = [];
    if (json['menu'] != null) {
      var menuData = json['menu'] as List;
      menuList = menuData.map((item) => Menu.fromJson(item)).toList();
    }

    return Order(
      idOrder: json['id_order'] as int,
      noStruk: json['no_struk'] as String,
      nama: json['nama'] as String,
      totalBayar: json['total_bayar'] as int,
      tanggal: json['tanggal'] as String,
      status: json['status'] as int,
      menu: menuList,
    );
  }
}

class Menu {
  int idMenu;
  String kategori;
  String nama;
  String foto;
  int jumlah;
  int harga;
  int total;
  String catatan;

  Menu({
    required this.idMenu,
    required this.kategori,
    required this.nama,
    required this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      idMenu: json['id_menu'] as int,
      kategori: json['kategori'] as String,
      nama: json['nama'] as String,
      foto: json['foto'] ?? "",
      jumlah: json['jumlah'] as int,
      harga: int.parse(json['harga']),
      total: json['total'] as int,
      catatan: json['catatan'] as String,
    );
  }
}
