import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hasta_takip/controller.dart';

import 'DoctorDetailsPage.dart';

class SymptomPage extends StatelessWidget {
  final String symptom;

  const SymptomPage({Key? key, required this.symptom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    Map<String, String> professionMap = {
      'Baş Ağrısı': 'Nöroloji',
      'Kaşıntı': 'Cildiye',
      'Göz Ağrısı': 'Göz Hastalıkları',
      'Kalp Ağrısı': 'Kardiyoloji',
      'Öksürük': 'Kulak Burun Boğaz',
      'Eklem Ağrısı': 'Ortopedi'
    };
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                width: 70,
              ),
              Text(
                "Önerilen Doktorlar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ]),
            Expanded(
              child: Obx(
                () {
                  if (_controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final matchedDoctors = _controller.doctorList
                        .where((doctor) =>
                            doctor.profession == professionMap[symptom])
                        .toList();
                    return ListView.builder(
                      itemCount: matchedDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = matchedDoctors[index];
                        return ListTile(
                          title:
                              Text(doctor.firstName! + " " + doctor.lastName!),
                          subtitle: Text(doctor.profession!),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Get.to(DoctorDetailPage(doctor: doctor));
                            // Navigate to the doctor details page.
                          },
                        );
                      },
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
