class UserModel {
  String token;
  String email;
  String userName;



  UserModel({
    required this.token,
    required this.email,
    required this.userName,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      userName: json['username'] ?? '',


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'email': email,
      'username': userName,

    };
  }
}
