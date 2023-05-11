import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hasta_takip/controller.dart';

import 'DoctorLoginPage.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    // DateTime date = DateTime.parse(_controller.doktor.value.birthDate!);
    //String formattedDate = DateFormat("dd-MM-yyyy").format(date);
    return Obx(() => SafeArea(
      child: Scaffold(
            backgroundColor: Colors.grey[300],
            body: Column(
              children: <Widget>[
                SizedBox(height: 10),
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
                          )),
                      Text(
                        "Profil Sayfası",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.offAll(DoctorLoginPage());
                          },
                          icon: Icon(Icons.logout, size: 30))
                    ]),
                SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/default.jpg",
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                              "Dr. " +_controller.doktor.value.firstName! +
                                  " " +
                                  _controller.doktor.value.lastName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height: 8),
                          Text(_controller.doktor.value.email!,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(_controller.doktor.value.profession!,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(_controller.doktor.value.adress!,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                           Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Text(_controller.doktor.value.bio!,
                                 style: TextStyle(fontSize: 16)),
                           ),
                          SizedBox(height: 10),
                          
                          // SizedBox(
                          //   width: 110,
                          //   child: ElevatedButton(
                          //       onPressed: (() {}),
                          //       child: Text("Edit Profile")),
                          // ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    ));
  }
}