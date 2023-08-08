class User {
  final int? idUser;
  final String? nama;
  final String? email;
  final String? tglLahir;
  final String? alamat;
  final String? telepon;
  final String? foto;
  final String? ktp;
  final String? pin;
  final bool? status;
  final bool? isCustomer;
  final int? rolesId;
  final String? roles;

  User({
    this.idUser,
    this.nama,
    this.email,
    this.tglLahir,
    this.alamat,
    this.telepon,
    this.foto,
    this.ktp,
    this.pin,
    this.status,
    this.isCustomer,
    this.rolesId,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      nama: json['nama'],
      email: json['email'],
      tglLahir: json['tgl_lahir'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      foto: json['foto'],
      ktp: json['ktp'],
      pin: json['pin'],
      status: json['status'] == 1,
      isCustomer: json['is_customer'] == 1,
      rolesId: json['roles_id'],
      roles: json['roles'],
    );
  }
}
