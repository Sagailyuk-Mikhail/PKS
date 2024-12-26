class UserModel {
  final String? token;
  final String? phone;
  final String? email;
  final String? name;

  UserModel({this.token, this.phone, this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'phone': phone,
      'email': email,
      'name': name,
    };
  }
}
