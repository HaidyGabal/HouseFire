class ListView_Messages {
  Data? data;
  String? message;

  ListView_Messages({this.data, this.message});

  ListView_Messages.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
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
  int? feedbackId;
  String? feedbackIdName;
  String? serviceName;
  DateTime? createdDate;


  Data({this.feedbackId, this.feedbackIdName, this.serviceName, //this.createdDate

  });

  Data.fromJson(Map<String, dynamic> json) {
    feedbackId = json['feedbackId'];
    feedbackIdName = json['feedbackIdName'];
    serviceName = json['serviceName'];
   // createdDate = json['createdDate'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feedbackId'] = feedbackId;
    data['feedbackIdName'] = feedbackIdName;
    data['serviceName'] = serviceName;
    //data['createdDate'] = createdDate;

    return data;
  }
}
