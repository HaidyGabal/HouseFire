class User {
  final int? userId;
  final String? userName;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? nationalID;
  final String? gender;
  final String? maritalStatus;
  final String? phone1;
  final String? phone2;
  final String? addressCity;
  final String? addressRegion;
  final String? addressStreet;
  final String? flameSensor;
  final int? gasSensor;
  final int? branchId;

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
      nationalID: json['national_ID'] as String?,
      gender: json['gender'] as String?,
      maritalStatus: json['marital_status'] as String?,
      phone1: json['phone1'] as String?,
      phone2: json['phone2'] as String?,
      addressCity: json['address_city'] as String?,
      addressRegion: json['address_Region'] as String?,
      addressStreet: json['address_street'] as String?,
      flameSensor: json['flame_sensor'] as String?,
      gasSensor: json['gas_sensor'] as int?,
      branchId: json['branch_id'] as int?,
    );
  }
}
