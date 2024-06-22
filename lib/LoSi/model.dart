
class UserModel {
  List<Data>? data;
  String? message;

  UserModel({this.data, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }

}


class Data {
  int? n_users_id;
  String? email;
  String? password;

  Data({this.email, this.password,this.n_users_id});

  Data.fromJson(Map<String, dynamic> json) {
    n_users_id = json['n_users_id'];
    email = json['email'];
    password = json['password'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['n_users_id'] = n_users_id;
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
