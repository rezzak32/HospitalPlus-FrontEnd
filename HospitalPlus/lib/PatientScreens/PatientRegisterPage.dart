import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/PatientScreens/PatientLoginPage.dart';
import 'package:hasta_takip/constant.dart';
import 'package:hasta_takip/Utilities/validator.dart';

import 'package:intl/intl.dart';

import '../Api/apiservice.dart';
import '../controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({
    Key? key,
  }) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {

  // @override
  // void initState() {
  //   super.initState();
  // }

  // kullanicikayityap() async {
  //   await APIService.yeniKullaniciKayit(
  //     _controller.firstNameController.text.toString(),
  //     _controller.lastNameController.text.toString(),
  //     _controller.userTypeController.text.toString(),
  //     _controller.emailController.text.toString(),
  //     _controller.passwordController.text.toString(),
  //     _controller.adressController.text.toString(),
  //     DateTime.parse(_controller.birthDateController.text),
  //   );
  //   Get.to(LoginPage());
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Text('Tebrikler Başarıyla Kayıt Oldunuz!'),
  //           actions: <Widget>[
  //             TextButton(
  //                 onPressed: Navigator.of(context).pop,
  //                 child: const Text('Tamam'))
  //           ],
  //         );
  //       });
  // }

  Widget build(BuildContext context) {
    final _formKey = new GlobalKey<FormState>().obs;
    final LoginController _controller = Get.find();

    hastakayityapProcess() async {
      _controller.bKullaniciKaydiBasarili(false);
      _controller.setLoading(true);

      if (_controller.firstNameController.text.toString().trim().isEmpty ==
          true) {
        //_controller.error = "Ad boş olamaz!";
        Get.snackbar(
          "",
          "Ad boş olamaz.",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }

      if (_controller.lastNameController.text.toString().trim().isEmpty ==
          true) {
        //_controller.error = "Soyad boş olamaz!";
        Get.snackbar(
          "",
          "Soyad boş olamaz.",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }
      

      if (_controller.emailController.text.toString().trim().isEmpty == true) {
        //_controller.error = "Mail adresi girmelisiniz!";
        Get.snackbar(
          "",
          "Email boş olamaz.",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }

      if (_controller.passwordController.text.toString().isEmpty == true) {
        //_controller.error = "Şifre boş olamaz!";
        Get.snackbar(
          "",
          "Şifre boş olamaz.",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }
      if (_controller.birthDateController.text.toString().isEmpty == true) {
        //_controller.error = "Doğum Tarihi boş olamaz!";
        Get.snackbar(
          "",
          "Doğum Tarihi boş olamaz.",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }
      //String? bos = null;
      if (!MyValidators()
          .eMailValidator(_controller.emailController.text.toString())) {
        Get.snackbar(
          "",
          "Lütfen Emailinizi kontrol edin.",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }

      if (!MyValidators()
          .passwordValidator(_controller.passwordController.text.toString())) {
        Get.snackbar(
          "",
          "Şifreniz minimum 6 karakter olmalıdır!",
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
        return;
      }

      //   if (!_controller.isValidEmail.value || !_controller.isValidPassword.value) {
      //   Get.snackbar(
      //     "",
      //     "Email yada şifrenizi kontrol edin.",
      //     icon: MyConstant.snackIconError,
      //     duration: Duration(seconds: MyConstant.snackDuration),
      //     //backgroundColor: MyConstant.snackBackgroundColorError,
      //   );
      //   return;
      // }

      await APIService.hastaKayit(
        _controller.firstNameController.text.toString(),
        _controller.lastNameController.text.toString(), 
        _controller.emailController.text.toString(),
        _controller.passwordController.text.toString(),
        _controller.adressController.text.toString(),
        DateTime.parse(_controller.birthDateController.text),
      );

      if (_controller.bApiIslem.value) {
        _controller.bKullaniciKaydiBasarili(true);
        Get.offAll(LoginPage());
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         content: Text('Tebrikler Başarıyla Kayıt Oldunuz!'),
        //         actions: <Widget>[
        //           TextButton(
        //               onPressed: Navigator.of(context).pop,
        //               child: const Text('Tamam'))
        //         ],
        //       );
        //     });
      } else {
        Get.snackbar(
          "Email Adresi Kullanımda!!",
          _controller.apiError.value.toString(),
          icon: MyConstant.snackIconError,
          duration: Duration(seconds: MyConstant.snackDuration),
          //backgroundColor: MyConstant.snackBackgroundColorError,
        );
      }
    }

    return Obx(() => SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
            child: Form(
          key: _formKey.value,
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Kayıt',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 40,
            ),
            // Ad
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
                    onSaved: (val) =>
                        _controller.firstNameController.text = val!,
                    controller: _controller.firstNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_outline),
                      border: InputBorder.none,
                      hintText: 'First Name',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Soyad
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
                    onSaved: (val) =>
                        _controller.lastNameController.text = val!,
                    controller: _controller.lastNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_outline),
                      border: InputBorder.none,
                      hintText: 'Last Name',
                    ),
                  ),
                ),
              ),
            ),     
            SizedBox(height: 10),
            // E-mail
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
                    onSaved: (val) =>
                        _controller.emailController.text = val!,
                    controller: _controller.emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Şifre
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
                    onSaved: (val) =>
                        _controller.passwordController.text = val!,
                    controller: _controller.passwordController,
                    obscureText: _controller.ispasswordHidden.value,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock_outline),
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              _controller.ispasswordHidden.value =
                                  !_controller.ispasswordHidden.value;
                            },
                            icon: Icon(
                              _controller.ispasswordHidden.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ))),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Adres
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
                    onSaved: (val) =>
                        _controller.adressController.text = val!,
                    controller: _controller.adressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.map_outlined),
                      border: InputBorder.none,
                      hintText: 'Adress',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Birth Date
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
                    controller: _controller.birthDateController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today_outlined),
                        border: InputBorder.none,
                        labelText: " Select your Birth Date"),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        _controller.birthDateController.text =
                            DateFormat('yyyy-MM-dd')
                                .format(pickedDate);
                      }
                      Map<String, dynamic> toJson() {
                        final DateFormat formatter =
                            DateFormat('yyyy-MM-dd');
                        final String formattedDate =
                            formatter.format(pickedDate!);

                        return {
                          'pickedDate': formattedDate,
                          
                        };
                      }

                      final Map<String, dynamic> data = toJson();
                      final jsonData = json.encode(data);
                      print(jsonData);
                    },
                  ),
                ),
              ),
            ),
            // Şifre onay
            /* Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                validator: (val) =>
                    val!.length == 0 ? 'Please enter your surname' : null,
                onSaved: (val) => _confirmpasswordController.text = val!,
                controller: _confirmpasswordController,
                obscureText: !_passwordVisible2,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible2 = !_passwordVisible2;
                          });
                        },
                        icon: Icon(
                          _passwordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ))),
              ),
            ),
          ),
        ), */
            SizedBox(
              height: 10,
            ),
            // Kayıt Butonu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: hastakayityapProcess,
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                    'Kayıt Ol',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kayıtlı mısın?',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    ' Giriş Yap',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
          ),
        )),
      ),
    ));
  }
}
