import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/PatientScreens/PatientLoginPage.dart';

import '../controller.dart';

class ProfilePage extends StatelessWidget {
  
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    // DateTime date = DateTime.parse(_controller.hasta.value.birthDate!);
    //String formattedDate = DateFormat("dd-MM-yyyy").format(date);
    return Obx(() => Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Column(
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
                            Get.offAll(LoginPage());
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
                              _controller.hasta.value.firstName! +
                                  " " +
                                  _controller.hasta.value.lastName!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height: 8),
                          Text(_controller.hasta.value.email!,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(_controller.hasta.value.adress!,
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          //Text(formattedDate,style: TextStyle(fontSize: 16)),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton(
                                onPressed: (() {}),
                                child: Text("Edit Profile")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.offAll(LoginPage());
                              },
                              child: Icon(Icons.logout_outlined, size: 32),
                            ),
                          ),
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
