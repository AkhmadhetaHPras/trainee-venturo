class SignInResponse {
  final int statusCode;
  final SignInData? data;
  final List<String>? errors;

  SignInResponse({
    required this.statusCode,
    this.data,
    this.errors,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      statusCode: json['status_code'],
      data: SignInData.fromJson(json['data']),
      errors: json['errors'],
    );
  }
}

class SignInData {
  final UserData user;
  final String token;

  SignInData({
    required this.user,
    required this.token,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) {
    return SignInData(
      user: UserData.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class UserData {
  final int idUser;
  final String email;
  final String nama;
  final String? foto;
  final int isGoogle;
  final int isCustomer;
  final String? roles;

  UserData({
    required this.idUser,
    required this.email,
    required this.nama,
    this.foto,
    required this.isGoogle,
    required this.isCustomer,
    this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      idUser: json['id_user'],
      email: json['email'],
      nama: json['nama'],
      foto: json['foto'],
      isGoogle: json['is_google'],
      isCustomer: json['is_customer'],
      roles: json['roles'],
    );
  }
}
