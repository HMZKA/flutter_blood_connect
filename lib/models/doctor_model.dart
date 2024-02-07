class DoctorModel {
  List<Doctor> doctors = [];
  DoctorModel.fromJson(Map<String, dynamic> json) {
    json["doctors"].forEach((element) {
      doctors.add(Doctor.fromJson(element));
    });
  }
}

class Doctor {
  dynamic name;
  dynamic image;
  Doctor.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
  }
}
