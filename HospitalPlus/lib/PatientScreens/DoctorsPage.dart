import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:hasta_takip/PatientScreens/DoctorDetailsPage.dart';

import 'package:hasta_takip/controller.dart';

class DoctorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.grey[300],
      //appBar: AppBar(title: Text('Doctor List')),
      body: SafeArea(
        child: Column(
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
                width: 75,
              ),
              Text(
                "Doktor Listesi",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ]),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: _controller.doctorList.length,
                    itemBuilder: (context, index) {
                      final Doctor doctor = _controller.doctorList[index];
                      return ListTile(
                        title: Text(doctor.firstName! + " " + doctor.lastName!),
                        subtitle: Text(doctor.profession!),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Get.to(DoctorDetailPage(doctor: doctor));
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
