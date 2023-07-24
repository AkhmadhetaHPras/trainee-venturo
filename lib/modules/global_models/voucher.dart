class Voucher {
  int? statusCode;
  List<VoucherData>? data;
  List<String>? errors;

  Voucher({
    this.statusCode,
    this.data,
    this.errors,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      statusCode: json['status_code'],
      data: json['data'] != null
          ? List<VoucherData>.from(
              json['data'].map((data) => VoucherData.fromJson(data)))
          : null,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
    );
  }
}

class VoucherData {
  int? idVoucher;
  String? nama;
  int? idUser;
  int? nominal;
  String? infoVoucher;
  int? periodeMulai;
  int? periodeSelesai;
  int? type;
  int? status;
  dynamic catatan;

  VoucherData({
    this.idVoucher,
    this.nama,
    this.idUser,
    this.nominal,
    this.infoVoucher,
    this.periodeMulai,
    this.periodeSelesai,
    this.type,
    this.status,
    this.catatan,
  });

  factory VoucherData.fromJson(Map<String, dynamic> json) {
    return VoucherData(
      idVoucher: json['id_voucher'],
      nama: json['nama'],
      idUser: json['id_user'],
      nominal: json['nominal'],
      infoVoucher: json['info_voucher'],
      periodeMulai: json['periode_mulai'],
      periodeSelesai: json['periode_selesai'],
      type: json['type'],
      status: json['status'],
      catatan: json['catatan'],
    );
  }
}
