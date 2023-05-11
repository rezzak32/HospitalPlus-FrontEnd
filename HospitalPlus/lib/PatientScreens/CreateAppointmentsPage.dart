import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';
import 'package:hasta_takip/PatientScreens/PatientHomePage.dart';
import 'package:hasta_takip/controller.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/UserModel.dart';

class AppointmentPage extends StatelessWidget {
  final _selectedDate = DateTime.now().obs;
  final _selectedTime = TimeOfDay.now().obs;
  final Doctor doctor;

  AppointmentPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
   
    randevuOlustur() async {
      final DateTime appointmentDateTime = DateTime(
        _selectedDate.value.year,
        _selectedDate.value.month,
        _selectedDate.value.day,
        _selectedTime.value.hour,
        _selectedTime.value.minute,
      );
      final int appointmentHour = _selectedTime.value.hour;
      if (appointmentHour < 8 || appointmentHour > 17) {
        Get.snackbar(
            "Hata", "Randevu sadece sabah 8 ile akşam 5 arasında alınabilir.");
        return;
      }
      await APIService.createAppointment(doctor.id!, appointmentDateTime,
          _controller.hasta.value.id!, _controller.randevu.value.syptomPicture);
      if (_controller.bApiIslem.value) {
        Get.offAll(HomePage());
        Get.snackbar("", "Randevunuz başarıyla oluşturuldu.");
      } else {
        // Hata mesajını göstermek için bir snackbar oluşturabilirsiniz.
        Get.snackbar("Hata", _controller.apiError.value);
      }
    }

    return Obx(() => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            body: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 28,
                      ),
                    ),
                    Text(
                      "Randevu oluştur",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 28,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Dr. " + doctor.firstName! + " " + doctor.lastName!,
                          style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 10),
                      Text("Uzmanlık: " + doctor.profession!,
                          style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            child: Text('Tarih Seç'),
                            onPressed: () => _selectDate(context),
                          ),
                          ElevatedButton(
                            child: Text('Saat Seç'),
                            onPressed: () => _selectTime(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.0),
                      Text(
                        'Seçilen Tarih: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Seçilen Saat: ${_selectedTime.value.hour.toString().padLeft(2, '0')}:${_selectedTime.value.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _getImage(),
                  child: Text("Dosya Yükle"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      randevuOlustur();
                    },
                    child: Text("Randevuyu onayla")),
              ],
            ),
          ),
        ));
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(Duration(days: 365)),
      currentTime: _selectedDate.value,
      locale: LocaleType.tr,
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime.value,
    );
    if (picked != null && picked != _selectedTime.value) {
      _selectedTime.value = picked;
    }
  }

  _getImage() async {
    final _controller = Get.put(LoginController());
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      final bytes = await image.readAsBytes();
      _controller.randevu.value.syptomPicture = bytes;
    }
  }
  
}
