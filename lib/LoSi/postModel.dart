class Data {
  int? userId;
  int? branchId; // Adjusted for nullable integer
  String roleName;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? nationalID;
  String? addressCity;
  String? addressRegion;
  String? addressStreet;
  String? phoneNumber;
  String? phoneNumber2;
  String? email;
  String? gender;
  String? maritalState;
  String? flameSensor;
  int? gasSensor;

  Data({
    this.userId,
    this.branchId,
    this.roleName = "User",
    this.userName,
    this.password,
    this.firstName,
    this.lastName,
    this.nationalID,
    this.addressCity,
    this.addressRegion,
    this.addressStreet,
    this.phoneNumber,
    this.phoneNumber2,
    this.email,
    this.gender,
    this.maritalState,
    this.flameSensor,
    this.gasSensor,
  });

  Data.fromJson(Map<String, dynamic> json)
      : roleName = json['roleName'] ?? 'User' {
    userId = json['n_users_id'];
    branchId = json['branchId'];
    userName = json['userName'];
    password = json['password'];
    nationalID = json['nationalID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    addressCity = json['addressCity'];
    addressRegion = json['addressRegion'];
    addressStreet = json['addressStreet'];
    phoneNumber = json['phoneNumber'];
    phoneNumber2 = json['phoneNumber2'];
    email = json['email'];
    gender = json['gender'];
    maritalState = json['maritalState'];
    flameSensor = json['flameSensor'];
    gasSensor = json['gasSensor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['n_users_id'] = userId;
    data['branchId'] = branchId;
    data['roleName'] = roleName;
    data['userName'] = userName;
    data['password'] = password;
    data['nationalID'] = nationalID;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['addressCity'] = addressCity;
    data['addressRegion'] = addressRegion;
    data['addressStreet'] = addressStreet;
    data['phoneNumber'] = phoneNumber;
    data['phoneNumber2'] = phoneNumber2;
    data['email'] = email;
    data['gender'] = gender;
    data['maritalState'] = maritalState;
    data['flameSensor'] = flameSensor;
    data['gasSensor'] = gasSensor;
    return data;
  }
}
