import 'dart:convert';

class Patient {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? adress;
  String? birthDate;
  int? id;

  Patient({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.adress,
    this.birthDate,
    this.id,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    adress = json['adress'];
    birthDate = json['birthDate'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['firstName'] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["password"] = password;
    data["adress"] = adress;
    data["birthDate"] = birthDate;
    data["id"] = id;

    return data;
  }
}

class Doctor {
  String? firstName;
  String? lastName;
  String? profession;
  String? email;
  String? password;
  String? adress;
  String? birthDate;
  String? bio;
  int? id;

  Doctor({
    this.firstName,
    this.lastName,
    this.profession,
    this.email,
    this.password,
    this.adress,
    this.birthDate,
    this.bio,
    this.id,
  });

  Doctor.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    profession = json['professionName'];
    email = json['email'];
    password = json['password'];
    adress = json['adress'];
    birthDate = json['birthDate'];
    bio= json['bio'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['firstName'] = firstName;
    data["lastName"] = lastName;
    data['professionName'] = profession;
    data["email"] = email;
    data["password"] = password;
    data["adress"] = adress;
    data["birthDate"] = birthDate;
    data['bio']= bio;
    data['id'] = id;

    return data;
  }
}

class Appointment {
  int? id;
  Patient? patient;
  Doctor? doctor;
  DateTime? appointmentDate;
  List<int>? syptomPicture;

  Appointment({
    this.id,
    this.patient,
    this.doctor,
    this.appointmentDate,
    this.syptomPicture
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient = Patient.fromJson(json['patient']);
    doctor = Doctor.fromJson(json['doctor']);
    appointmentDate = DateTime.parse(json['appointmentDate']);
    final symptomPictureJson = json['symptomPicture'];
  if (symptomPictureJson != null) {
    final bytes = base64.decode(symptomPictureJson);
    syptomPicture = List<int>.from(bytes);
  }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = id;
    data['patient'] = patient!.toJson();
    data['doctor'] = doctor!.toJson();
    data['appointmentDate'] = appointmentDate!.toIso8601String();
    data['symptomPicture'] = syptomPicture;

    return data;
  }
}





