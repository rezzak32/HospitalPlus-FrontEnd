import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:hasta_takip/PatientScreens/DoctorDetailsPage.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Get.to(DoctorDetailPage(doctor: doctor));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.deepPurple[200],
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  "assets/images/default.jpg",
                  height: 110,
                ),
              ),
              SizedBox(height: 5),
              Text(
                doctor.firstName! + " " + doctor.lastName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(doctor.profession!),
            ],
          ),
        ),
      ),
    );
  }
}
