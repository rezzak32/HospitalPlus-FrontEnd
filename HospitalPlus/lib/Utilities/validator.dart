import 'package:get/get.dart';

import '../controller.dart';

class MyValidators {
  final _controller = Get.put(LoginController()); // inject controller

  bool eMailValidator(String email) {
    bool sonuc = false;
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    if (emailValid) {
      sonuc = true;
    } else {
      _controller.error = "Geçerli bir mail adresi girmelisiniz!!";
      sonuc = false;
    }

    if (email.contains(' ')) {
      sonuc = false;
      _controller.error = "Geçerli bir mail adresi girmelisiniz!!";
    }

    return sonuc;
  }

  bool eMailValidator2(String email) {
    bool sonuc = false;
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    //Convert string p to a RegEx
    RegExp regExp = new RegExp(p);
    //If email address matches pattern
    if (regExp.hasMatch(email)) {
      sonuc = true;
    } else {
      sonuc = false;
      _controller.error = "Geçerli bir mail adresi girmelisiniz!!";
    }

    if (email.contains(' ')) {
      sonuc = false;
      _controller.error = "Geçerli bir mail adresi girmelisiniz!!";
    }

    return sonuc;
  }

  bool passwordValidator(String password) {
    bool sonuc = false;

    if (password.length < 6) {
      sonuc = false;
      _controller.error = "Şifreniz minimum 6 karakter olmalıdır!!";
    } else {
      sonuc = true;
    }

    if (password.contains(' ')) {
      sonuc = false;
      _controller.error = "Şifrenizde boşluk olamaz!!";
    }

    return sonuc;
  }
}
