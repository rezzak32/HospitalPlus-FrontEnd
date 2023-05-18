import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';

import 'package:hasta_takip/Models/UserModel.dart';
import 'package:intl/intl.dart';

class PastAppointments extends StatelessWidget {
  final int patientId;

  const PastAppointments({Key? key, required this.patientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('HH:mm');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
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
              SizedBox(
                width: 45,
              ),
              Text(
                "Geçmiş Randevularım",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ]),
            Expanded(
              child: FutureBuilder<List<Appointment>>(
                future: APIService.getAppointmentByPatientId(patientId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final appointments = snapshot.data!.where((appointment) => appointment.appointmentDate!.isBefore(DateTime.now())).toList();
                    
                    appointments.sort((a, b) => b.appointmentDate!.compareTo(a.appointmentDate!)); // sort by appointment date
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
                          title: Text("Dr. " +
                              appointment.doctor!.firstName! +
                              ' ' +
                              appointment.doctor!.lastName!),
                          subtitle: Text(dateFormat
                                  .format(appointment.appointmentDate!) +
                              "-" +
                              timeFormat.format(appointment.appointmentDate!)),
                          trailing: Text('Tamamlandı'),
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
