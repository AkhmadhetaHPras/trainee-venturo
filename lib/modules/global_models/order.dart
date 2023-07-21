class Order {
  int idUser;
  int idVoucher;
  int potongan;
  int totalBayar;

  Order({
    required this.idUser,
    required this.idVoucher,
    required this.potongan,
    required this.totalBayar,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      idUser: json['id_user'],
      idVoucher: json['id_voucher'],
      potongan: json['potongan'],
      totalBayar: json['total_bayar'],
    );
  }
}
