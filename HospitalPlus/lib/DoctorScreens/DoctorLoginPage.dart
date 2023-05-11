import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hasta_takip/Api/apiservice.dart';
import 'package:hasta_takip/PatientScreens/PatientLoginPage.dart';
import 'package:hasta_takip/constant.dart';
import 'package:hasta_takip/controller.dart';

import '../Utilities/RememberMe.dart';
import 'DoctorHomePage.dart';

class DoctorLoginPage extends StatelessWidget {
  const DoctorLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(LoginController());
    doktorgirisYapProcess() async {
      _controller.setLoading(true);

      if (_controller.emailController.text.toString().trim().isEmpty == true) {
        Get.snackbar(
          "",
          "Mail adresi girmelisiniz!",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }

      if (_controller.passwordController.text.toString().isEmpty == true) {
        Get.snackbar(
          "",
          "Şifre alanı boş olamaz!",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }

      await APIService.doktorgirisYap(_controller.emailController.text.toString(),
          _controller.passwordController.text.toString());

      if (_controller.apiOk.value) {
        final box = GetStorage();
        String benihatirla = _controller.hatirla.toString();

        if (benihatirla == "true") {
          box.write("email", _controller.emailController.text.toString());
          box.write("password", _controller.passwordController.text.toString());
          box.write("hatirla", benihatirla);
        } else {
          box.write("email", "");
          box.write("password", "");
          box.write("hatirla", "false");
        }
        // if (_controller.kullanici.value.userType == "Hasta") {
        //   Get.offAll(HomePage());
        // }
        // if (_controller.kullanici.value.userType == "Doktor") {
        //   Get.offAll(DoctorHomePage());
        // }
        Get.offAll(DoctorHomePage());
      } else {
        Get.snackbar(
          "",
          _controller.apiError.value.toString(),
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
      }
    }

    return Obx(() =>SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: <Widget>[
            Center(
              child: ListView(
                children: [
                  SizedBox(height: 180),
                  Center(
                    child: Text("Doktor",
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: _controller.emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_outline),
                            border: InputBorder.none,
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          controller: _controller.passwordController,
                          obscureText: !_controller.ispasswordHidden.value,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock_outline),
                              border: InputBorder.none,
                              hintText: 'Password',
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _controller.ispasswordHidden.value =
                                        !_controller.ispasswordHidden.value;
                                  },
                                  icon: Icon(
                                    _controller.ispasswordHidden.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  // Beni Hatırla
                  CChechBoxBeniHatirla(),
                  SizedBox(height: 10),
                  // giriş yap
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () async {
                        await doktorgirisYapProcess();
                        _controller.setLoading(false);
                      },
                      child: Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: Text(
                          'Giriş Yap',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                            onTap: () {
                              Get.to(LoginPage());
                            },
                            child: Text(
                              ' Hasta Girişi Yap',
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
