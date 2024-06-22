class MessPostModel {
  Data? data;
  String? message;

  MessPostModel({this.data, this.message});

  factory MessPostModel.fromJson(Map<String, dynamic> json) {
    return MessPostModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {

  int? usersId;
  String?firstName;
  String?lastName;
  String? services_name;
  String? feedback_name;
  DateTime? feedbackDate;



  Data({this.services_name, this.feedback_name, this.feedbackDate,this.firstName,this.lastName,this.usersId});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      usersId: json['n_users_id'],

      services_name: json['services_name'],
      feedback_name: json['feedback_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      feedbackDate: DateTime.parse(json['feedback_date']), // Uncomment if needed
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['n_users_id'] = usersId;

    data['services_name'] = services_name;
    data['feedback_name'] = feedback_name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
     data['feedback_date'] = feedbackDate?.toIso8601String(); // Uncomment if needed
    return data;
  }
}
