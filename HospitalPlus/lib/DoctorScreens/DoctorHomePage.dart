import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';
import 'package:hasta_takip/DoctorScreens/DoctorAppointments.dart';
import 'package:hasta_takip/DoctorScreens/DoctorProfile.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:hasta_takip/Utilities/Appointment_Card.dart';
import 'package:hasta_takip/controller.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());

    return Obx(() => SafeArea(
            child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Merhaba,",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Dr. " +
                              _controller.doktor.value.firstName! +
                              " " +
                              _controller.doktor.value.lastName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.to(DoctorProfilePage());
                      },
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Yaklaşan Randevular",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        child: Text("Hepsini Gör",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        onTap: () async{
                          
                          Get.to(DoctorAppointmentsPage(
                              doctorId: _controller.doktor.value.id!));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 160,
                child: FutureBuilder<List<Appointment>>(
                  future: APIService.getAppointmentByDoctorId(_controller
                      .doktor.value.id!), // replace 123 with the doctor ID
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final appointments = snapshot.data!.where((appointment) => appointment.appointmentDate!.isAfter(DateTime.now())).toList();
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = appointments[index];
                          return AppointmentCard(appointment: appointment);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          )),
        )));
  }
}
