class ProfileModel {
  String? token;
  User? user;
  ProfileModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    user = User.fromJson(json["data"]);
  }
}

class User {
  String? name;
  String? phone;
  String? identityNumber;
  int? donationCount;
  int? orderCount;
  User.fromJson(Map<String, dynamic> json) {
    name = "${json["first_name"]} ${json["last_name"]}";
    phone = json["phone"];
    identityNumber = json["identity_number"];
    donationCount = json["donation_count"];
    orderCount = json["order_count"];
  }
}
