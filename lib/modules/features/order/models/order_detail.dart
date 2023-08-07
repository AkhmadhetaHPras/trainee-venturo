import 'dart:convert';

class OrderDetail {
  OrderHeader? order;
  List<Detail>? detail;

  OrderDetail({
    this.order,
    this.detail,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    List<Detail> detailList = [];
    if (json['detail'] != null) {
      var detailData = json['detail'] as List;
      detailList = detailData.map((item) => Detail.fromJson(item)).toList();
    }

    return OrderDetail(
      order: OrderHeader.fromJson(json['order']),
      detail: detailList,
    );
  }
}

class OrderHeader {
  int idOrder;
  String noStruk;
  String nama;
  int idVoucher;
  String? namaVoucher;
  int diskon;
  int potongan;
  int totalBayar;
  String tanggal;
  int status;

  OrderHeader({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.idVoucher,
    this.namaVoucher,
    required this.diskon,
    required this.potongan,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
  });

  factory OrderHeader.fromJson(Map<String, dynamic> json) {
    return OrderHeader(
      idOrder: json['id_order'] as int,
      noStruk: json['no_struk'] as String,
      nama: json['nama'] as String,
      idVoucher: json['id_voucher'] as int,
      namaVoucher: json['nama_voucher'] as String?,
      diskon: json['diskon'] as int,
      potongan: json['potongan'] as int,
      totalBayar: json['total_bayar'] as int,
      tanggal: json['tanggal'] as String,
      status: json['status'] as int,
    );
  }
}

class Detail {
  int idMenu;
  String kategori;
  List<int> topping;
  String nama;
  String? foto;
  int jumlah;
  int harga;
  int total;
  String catatan;

  Detail({
    required this.idMenu,
    required this.kategori,
    required this.topping,
    required this.nama,
    this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    List<int> toppingList = (json['topping'] as String).isNotEmpty
        ? List<int>.from(jsonDecode(json['topping']) as List<dynamic>)
        : [];
    return Detail(
      idMenu: json['id_menu'] as int,
      kategori: json['kategori'] as String,
      topping: toppingList,
      nama: json['nama'] as String,
      foto: json['foto'],
      jumlah: json['jumlah'] as int,
      harga: int.parse(json['harga']),
      total: json['total'] as int,
      catatan: json['catatan'] as String,
    );
  }
}
