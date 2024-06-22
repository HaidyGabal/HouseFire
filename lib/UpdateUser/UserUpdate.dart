class User {
  int? userId;
  String? userName;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? nationalID; // Adjusted field name
  String? gender;
  String? maritalStatus; // Adjusted field name
  String? phone1;
  String? phone2;
  String? addressCity; // Adjusted field name
  String? addressRegion;
  String? addressStreet;
  String? flameSensor;
  String? gasSensor;
  int? branchId;

  User({
    this.userId,
    this.userName,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.nationalID,
    this.gender,
    this.maritalStatus,
    this.phone1,
    this.phone2,
    this.addressCity,
    this.addressRegion,
    this.addressStreet,
    this.flameSensor,
    this.gasSensor,
    this.branchId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['n_users_id'] as int?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      nationalID: json['national_ID'] as String?, // Adjusted field name
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?, // Adjusted field name
      phone1: json['phone1'] as String?,
      phone2: json['phone2'] as String?,
      addressCity: json['address_city'] as String?, // Adjusted field name
      addressRegion: json['address_Region'] as String?,
      addressStreet: json['address_street'] as String?,
      flameSensor: json['flame_sensor'] as String?,
      gasSensor: json['gas_sensor'] as String?,
      branchId: json['branch_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n_users_id': userId,
      'user_name': userName,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'national_ID': nationalID, // Adjusted field name
      'gender': gender,
      'marital_status': maritalStatus, // Adjusted field name
      'phone1': phone1,
      'phone2': phone2,
      'address_city': addressCity, // Adjusted field name
      'address_Region': addressRegion,
      'address_street': addressStreet,
      'flame_sensor': flameSensor,
      'gas_sensor': gasSensor,
      'branch_id': branchId,
    };
  }
}
