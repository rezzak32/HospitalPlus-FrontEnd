import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/Api/apiservice.dart';
import 'package:hasta_takip/Models/UserModel.dart';
import 'package:hasta_takip/PatientScreens/DoctorsPage.dart';
import 'package:hasta_takip/PatientScreens/PatientAppointments.dart';
import 'package:hasta_takip/PatientScreens/PatientProfilePage.dart';
import 'package:hasta_takip/Utilities/Category_Card.dart';
import 'package:hasta_takip/Utilities/Doctor_Card.dart';
import 'package:hasta_takip/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    List<String> symptomCategories = [
      'Baş Ağrısı',
      'Kaşıntı',
      'Göz Ağrısı',
      'Kalp Ağrısı',
      'Öksürük',
      'Eklem Ağrısı'
    ];

    return Obx(() => Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
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
                            _controller.hasta.value.firstName! +
                                " " +
                                _controller.hasta.value.lastName!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          Get.to(ProfilePage());
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () async {
                          await APIService.doktorlariGetir();
                          Get.to(DoctorListPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.deepPurple,
                                  size: 35,
                                ),
                              ),
                              SizedBox(height: 25),
                              Text(
                                "Randevu Oluştur",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () async {
                          Get.to(PatientAppointments(
                              patientId: _controller.hasta.value.id!));
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.deepPurple,
                                  size: 35,
                                ),
                              ),
                              SizedBox(height: 25),
                              Text(
                                "Randevularım     ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //SizedBox(width: 20),
                      Text(
                        "Semptomlarınız neler?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: symptomCategories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(
                          categoryName: symptomCategories[index],
                        );
                      },
                    )),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Doktor Listesi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await APIService.doktorlariGetir();
                          Get.to(DoctorListPage());
                        },
                        child: Text(
                          "Hepsini gör",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (_controller.doctorList.isNotEmpty) {
                    return SizedBox(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final Doctor doctor = _controller.doctorList[index];
                          return DoctorCard(doctor: doctor);
                        },
                      ),
                    );
                  } else if (_controller.doctorList.isEmpty) {
                    return Center(child: Text('Failed to fetch doctors'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
                //SizedBox(height: 15),
              ],
            ),
          ),
        )));
  }
}
