import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasta_takip/controller.dart';

// ignore: must_be_immutable
class CChechBoxBeniHatirla extends StatelessWidget {
  //const CChechBox({Key key}) : super(key: key);

  LoginController _controller = Get.find(); // bu şekilde

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CheckboxListTile(
        title: Text(
          "Beni hatırla",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
        value: _controller.hatirla.value,

        activeColor: Theme.of(context).primaryColor,
        onChanged: (value) {
          _controller.hatirla.value = !_controller.hatirla.value;
        },

        controlAffinity:
            ListTileControlAffinity.platform, //  <-- leading Checkbox
      ),
    );
  }
}