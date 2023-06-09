import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';
import 'package:hasta_takip/DoctorScreens/PastDoctorAppointmentsPage.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  final int doctorId;

  const DoctorAppointmentsPage({Key? key, required this.doctorId})
      : super(key: key);

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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 28,
                  )),
             
              Text(
                "Randevu Takvimi",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              
              IconButton(
            icon: Icon(Icons.history,size: 28,),
            onPressed: () {
              Get.to(PastDoctorAppointments(doctorId: doctorId));
            },
          ),
            ]),
            Expanded(
              child: FutureBuilder<List<Appointment>>(
                future: APIService.getAppointmentByDoctorId(doctorId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final appointments = snapshot.data!.where((appointment) => appointment.appointmentDate!.isAfter(DateTime.now())).toList();
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
