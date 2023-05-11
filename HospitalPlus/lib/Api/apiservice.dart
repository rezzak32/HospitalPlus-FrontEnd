import 'dart:convert';

import 'package:get/get.dart';

import 'package:hasta_takip/Models/UserModel.dart';

import 'package:http/http.dart';

import '../controller.dart';

class APIService {
 
  static hastaKayit(String firstName, String lastName, String email, String password, String? adress, DateTime birthDate) async {
    final LoginController loginController = Get.find();
    loginController.bApiIslem.value = false;
    loginController.error = "";

    var url = Uri.parse("http://192.168.1.37/medical/register");
    Map<String, String> headers = {"Content-type": "application/json"};

    var data = {};
    //print(loginController.firstNameController.value);
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["password"] = password;
    data["adress"] = adress;
    data["birthDate"] = birthDate;
    String isoBirthDate = birthDate.toIso8601String();
    data["birthDate"] = isoBirthDate;
    String _data = json.encode(data);

    try {
      var response = await post(url, headers: headers, body: _data);

      if (response.statusCode == 200) {
        // ignore: avoid_init_to_null
        var jsonResponse = null;

        loginController.bApiIslem.value = true;
        // _controller.apiError.value = "";

        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {}
      } else {
        try {
          loginController.bApiIslem.value = false;
          var jsonResponse;
          jsonResponse = json.decode(response.body);
          //String hata = jsonResponse['message'].toString();
          // _controller.apiError.value = hata;
        } catch (_) {
          // _controller.apiError.value = "Merkez servis erişminde hata oluştu!";
        }
      }
    } catch (_) {
      // _controller.apiOk.value = false;
      // _controller.apiError.value = "Merkez servis erişiminde hata olustu!";
    }
  }

  static hastagirisYap(String email, String password) async {
    bool baktif = Get.isRegistered<LoginController>();
    if (!baktif) {
      Get.put(LoginController());
    }
    final LoginController _controller = Get.find();

    var url = Uri.parse("http://192.168.1.37/medical/loginPatient");
    Map<String, String> headers = {"Content-type": "application/json"};

    var data = {};
    data["email"] = email.trimRight();
    data["password"] = password;

    String _data = json.encode(data);

    _controller.passwordController.text = "";
    _controller.emailController.text = "";
    _controller.apiOk.value = false;
    _controller.apiError.value = "";
    Patient resModel;
    try {
      var response = await post(url, headers: headers, body: _data);

      if (response.statusCode == 200) {
        // ignore: avoid_init_to_null
        var jsonResponse = null;

        _controller.passwordController.text = password;
        _controller.emailController.text = email;
        _controller.apiOk.value = true;
        // _controller.bApiIslem.value = true;
        jsonResponse = json.decode(response.body);
        resModel = Patient.fromJson(jsonResponse['result']);

        _controller.hasta.value.firstName = resModel.firstName;
        _controller.hasta.value.lastName = resModel.lastName;
        _controller.hasta.value.email = resModel.email;
        _controller.hasta.value.password = resModel.password;
        _controller.hasta.value.adress = resModel.adress;
        _controller.hasta.value.birthDate = resModel.birthDate;
        _controller.hasta.value.id = resModel.id;
        return new Patient.fromJson(jsonResponse);
      } else {
        try {
          _controller.apiOk.value = false;
          var jsonResponse;
          jsonResponse = json.decode(response.body);
          String hata = jsonResponse['message'].toString();
          _controller.apiError.value = hata;
        } catch (_) {
          _controller.apiError.value = "Merkez servis erişminde hata oluştu!";
        }
      }
    } catch (_) {
      _controller.apiOk.value = false;
      _controller.apiError.value = "Merkez servis erişiminde hata oluştu!";
    }
  }

  static doktorgirisYap(String email, String password) async {
    bool baktif = Get.isRegistered<LoginController>();
    if (!baktif) {
      Get.put(LoginController());
    }
    final LoginController _controller = Get.find();

    var url = Uri.parse("http://192.168.1.37/medical/loginDoctor");

    //var url =   Uri.parse("http://sdrmobil.acilimsoft.com/Merkez/user/authenticate");
    //url = Uri.parse("http://192.168.1.32:5001/user/Authenticate");

    Map<String, String> headers = {"Content-type": "application/json"};

    var data = {};
    data["email"] = email.trimRight();
    data["password"] = password;

    String _data = json.encode(data);

    _controller.passwordController.text = "";
    _controller.emailController.text = "";
    _controller.apiOk.value = false;
    _controller.apiError.value = "";
    Doctor resModel;
    try {
      var response = await post(url, headers: headers, body: _data);

      if (response.statusCode == 200) {
        // ignore: avoid_init_to_null
        var jsonResponse = null;

        _controller.passwordController.text = password;
        _controller.emailController.text = email;
        _controller.apiOk.value = true;
        // _controller.bApiIslem.value = true;
        jsonResponse = json.decode(response.body);
        resModel = Doctor.fromJson(jsonResponse['result']);

        _controller.doktor.value.firstName = resModel.firstName;
        _controller.doktor.value.lastName = resModel.lastName;
        _controller.doktor.value.profession = resModel.profession;
        _controller.doktor.value.email = resModel.email;
        _controller.doktor.value.password = resModel.password;
        _controller.doktor.value.adress = resModel.adress;
        _controller.doktor.value.birthDate = resModel.birthDate;
        _controller.doktor.value.bio =resModel.bio;
        _controller.doktor.value.id = resModel.id;
        return new Doctor.fromJson(jsonResponse);
      } else {
        try {
          _controller.apiOk.value = false;
          var jsonResponse;
          jsonResponse = json.decode(response.body);
          String hata = jsonResponse['message'].toString();
          _controller.apiError.value = hata;
        } catch (_) {
          _controller.apiError.value = "Merkez servis erişminde hata oluştu!";
        }
      }
    } catch (_) {
      _controller.apiOk.value = false;
      _controller.apiError.value = "Merkez servis erişiminde hata oluştu!";
    }
  }

  static Future<List<Doctor>> doktorlariGetir() async {
    final response =
        await get(Uri.parse('http://192.168.1.37/medical/api/doctor/GetAll'));
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      if (json != null) {
        
        final List<dynamic> doctorList = json['result'];
        return doctorList.map((e) => Doctor.fromJson(e)).toList();
      } else {
        throw Exception('API returned null data');
      }
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  static Future<List<Doctor>> matchDoctors(String symptom) async {
     Map<String, String> professionMap = {
    'Baş Ağrısı': 'Nöroloji',
    'Kaşıntı': 'Cildiye',
    'Göz Ağrısı': 'Göz Hastalıkları',
    'Kalp Ağrısı': 'Kardiyoloji',
    'Öksürük':'Kulak Burun Boğaz',
    'Eklem Ağrısı':'Ortopedi'
  };
    final response =
        await get(Uri.parse('http://192.168.1.37/medical/api/doctor/GetAll'));
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      if (json != null) {
        final List<dynamic> doctorList = json['result'];
        final String profession = professionMap[symptom]!;
        return doctorList
            .map((e) => Doctor.fromJson(e))
            .where((doctor) => doctor.profession == profession)
            .toList();
      } else {
        throw Exception('API returned null data');
      }
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  
   static createAppointment(int doctorId, DateTime appointmentDate,int patientId,List<int>? syptomPicture) async {
    var _controller = Get.put(LoginController());
    

    var url = Uri.parse("http://192.168.1.37/medical/api/Appointment/CreateAppointment");
    var headers = {"Content-type": "application/json"};
    var data = {};
    data = {
      "patientId": patientId,
      "doctorId": doctorId,
      "appointmentDate": appointmentDate.toIso8601String(),
    };
    if (syptomPicture != null) {
    data["symptomPicture"] = base64Encode(syptomPicture);
  }

    var body = json.encode(data);
    Appointment resModel;
    try {
      var response = await post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        
        _controller.bApiIslem.value = true;
        resModel = Appointment.fromJson(jsonResponse['result']);
        _controller.randevu.value.appointmentDate = resModel.appointmentDate;
        _controller.randevu.value.syptomPicture = resModel.syptomPicture;
        _controller.randevu.value.id = resModel.id;

        return new Appointment.fromJson(jsonResponse);
      } else {
        var jsonResponse = json.decode(response.body);
        _controller.apiError.value = jsonResponse['message'];
      }
    } catch (_) {
      _controller.apiError.value= "Bağlantı hatası";
    }
  }

  
  static Future<List<Appointment>> getAppointmentByPatientId(int id) async{
    final response =
        await get(Uri.parse('http://192.168.1.37/medical/api/Appointment/getByPatientId?id='+ id.toString()));
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      if (json != null) {
        final List<dynamic> appointmentsJson = json['result'];
        List<Appointment> appointments = [];
        for (dynamic appointmentJson in appointmentsJson) {
          Appointment appointment = Appointment.fromJson(appointmentJson);
          
          // Set the doctor for the appointment
          if (appointmentJson['doctor'] != null) {
            Doctor doctor = Doctor.fromJson(appointmentJson['doctor']);
            appointment.doctor = doctor;
          }

          // Set the patient for the appointment
          if (appointmentJson['patient'] != null) {
            Patient patient = Patient.fromJson(appointmentJson['patient']);
            appointment.patient = patient;
          }
          
          appointments.add(appointment);
        }
        return appointments;
      } else {
        throw Exception('API returned null data');
      }
    } else {
      throw Exception('Failed to fetch appointments');
    }
}
  static Future<List<Appointment>> getAppointmentByDoctorId(int id) async{
    final response =
        await get(Uri.parse('http://192.168.1.37/medical/api/Appointment/getByDoctorId?id='+ id.toString()));
    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      if (json != null) {
        final List<dynamic> appointmentsJson = json['result'];
        List<Appointment> appointments = [];
        for (dynamic appointmentJson in appointmentsJson) {
          Appointment appointment = Appointment.fromJson(appointmentJson);
          
          // Set the doctor for the appointment
          if (appointmentJson['doctor'] != null) {
            Doctor doctor = Doctor.fromJson(appointmentJson['doctor']);
            appointment.doctor = doctor;
          }

          // Set the patient for the appointment
          if (appointmentJson['patient'] != null) {
            Patient patient = Patient.fromJson(appointmentJson['patient']);
            appointment.patient = patient;
          }
          
          appointments.add(appointment);
        }
        return appointments;
      } else {
        throw Exception('API returned null data');
      }
    } else {
      throw Exception('Failed to fetch appointments');
    }
}
}

