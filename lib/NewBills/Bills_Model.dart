class BillsModel {
  List<Bill>? data;
  String? message;

  BillsModel({this.data, this.message});

  BillsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<Bill>.from(json['data'].map((e) => Bill.fromJson(e)));
    }
    message = json['message'];
  }
}

class Bill {
  int billsId;
  DateTime billDate;
  double invoiceValue;
  double consumptionValue;
  double installmentValue;
  int userId;
  int serviceId;
  String city;
  String region;
  String street;
  String firstName;
  String lastName;
  String nationalId;
  String email;
  String phone1;
  String phone2;

  Bill({
    required this.billsId,
    required this.billDate,
    required this.invoiceValue,
    required this.consumptionValue,
    required this.installmentValue,
    required this.userId,
    required this.serviceId,
    required this.city,
    required this.region,
    required this.street,
    required this.firstName,
    required this.lastName,
    required this.nationalId,
    required this.email,
    required this.phone1,
    required this.phone2,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      billsId: json['bills_id'] ?? 0,
      billDate: DateTime.parse(json['bill_date'] ?? DateTime.now().toString()),
      invoiceValue: (json['invoice_value'] ?? 0).toDouble(),
      consumptionValue: (json['consumption_value'] ?? 0).toDouble(),
      installmentValue: (json['installment_value'] ?? 0).toDouble(),
      userId: json['n_users_id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      city: json['address_city'] ?? '',
      region: json['address_Region'] ?? '',
      street: json['address_street'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      nationalId: json['national_ID'] ?? '',
      email: json['email'] ?? '',
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
    );
  }
}
