import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hasta_takip/constant.dart';
import 'package:hasta_takip/controller.dart';

class RowC extends StatelessWidget {
  final _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          
          onPressed: () async {
            _controller.setLoading(true);
            //await forgotpasswordProcess();

            _controller.setLoading(false);
          },
          child: Text(
            "Şifremi Unuttum",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ),
        
      ],
    );
  }

  forgotpasswordProcess() async {
    if (_controller.emailController.text.toString().trim().isEmpty == true) {
      Get.snackbar(
        "",
        "Mail adresi girmelisiniz!",
        icon: MyConstant.snackIconError,
        duration: Duration(seconds: MyConstant.snackDuration),
       // backgroundColor: MyConstant.snackBackgroundColorError,
      );
      return;
    }

    // await APIService.forgotMyPassword(
    //   _controller.emailController.text.toString().trim(),
    // );

    if (_controller.apiOk.value) {
      Get.snackbar(
        "",
        "Yeni şifresiniz mail adresinize gönderildi!",
        duration: Duration(seconds: MyConstant.snackDuration),
        icon: MyConstant.snackIconSucces,
        //backgroundColor: MyConstant.snackBackgroundColorSucces,
      );
    } else {
      Get.snackbar(
        "",
        _controller.apiError.toString(),
        duration: Duration(seconds: MyConstant.snackDuration),
        icon: MyConstant.snackIconError,
        //backgroundColor: MyConstant.snackBackgroundColorError,
      );
    }
  }
}