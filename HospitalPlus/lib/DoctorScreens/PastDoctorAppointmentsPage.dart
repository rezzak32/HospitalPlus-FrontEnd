import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:intl/intl.dart';

class PastDoctorAppointments extends StatelessWidget {
  final int doctorId;
  const PastDoctorAppointments({super.key, required this.doctorId});

   @override
  Widget build(BuildContext context) {
    //final _controller = Get.put(LoginController());
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('HH:mm');
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          children: [
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 28,
                  )),
             SizedBox(width: 60),
              Text(
                "Geçmiş Randevular",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              
              
            ]),
            Expanded(
              child: FutureBuilder<List<Appointment>>(
                future: APIService.getAppointmentByDoctorId(doctorId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final appointments = snapshot.data!.where((appointment) => appointment.appointmentDate!.isBefore(DateTime.now())).toList();
                    if (appointments.isEmpty) {
                      return Center(
                        child: Text('Randevu Bulunamadı'),
                      );
                    }
                    return ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];
                        return ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                if (appointment.syptomPicture == null) {
                                  return AlertDialog(
                                    title: Text('Fotoğraf Yok'),
                                    content: Text(
                                        'Hastanın semptom fotoğrafı bulunamadı.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Tamam'),
                                      ),
                                    ],
                                  );
                                } else {
                                  return AlertDialog(
                                    content: Image.memory(
                                      Uint8List.fromList(appointment.syptomPicture!),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          title: Text(appointment.patient!.firstName! +
                              ' ' +
                              appointment.patient!.lastName!),
                          subtitle: Text(dateFormat.format(appointment.appointmentDate!)+ "-" +timeFormat.format(appointment.appointmentDate!)),
                         
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}