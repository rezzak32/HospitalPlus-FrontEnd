import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hasta_takip/Api/apiservice.dart';

import 'Models/UserModel.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  RxBool isValidPassword = false.obs;
  RxBool isValidEmail = false.obs;

  //final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final symptom = "".obs;
  var error = "";
  String data = "test";
  final storage = GetStorage();
  var ispasswordHidden = true.obs;
  Rx<Patient> hasta = new Patient().obs;
  Rx<Doctor> doktor = new Doctor().obs;
  Rx<Appointment> randevu = new Appointment().obs;
  RxBool bApiIslem = false.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final adressController = TextEditingController();
  final birthDateController = TextEditingController();
  final searchController = TextEditingController();
  final hatirla = false.obs;
  RxBool apiOk = false.obs;
  var apiError = "".obs;
  var password = "".obs;
  var email = "".obs;

  RxList<Doctor> doctorList = RxList<Doctor>([]);
  //final lisanskabul = false.obs;

  RxBool bKullaniciKaydiBasarili = false.obs;

  @override
  void onInit() {
    //testnumber.value = 0;
    apiOk.value = false;
    hatirla.value = GetStorage().read("hatirla") == "true" ? true : false;

    emailController.text = storage.read("email").toString() == "null"
        ? ""
        : storage.read("email").toString();
    passwordController.text = storage.read("password") == null
        ? ""
        : storage.read("password").toString();
    isLoading.value = false;
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    //isRefresh.value = false;
    //allCountx = null;
    //loadPAckageInfo();

    //searchController.text = "";
    //myFocusNode = FocusNode();
    getDoctorList();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    apiOk.value = false;
    isLoading.value = false;
    super.onClose();
  }

  void setLoading(bool value) {
    isLoading.value = value;
    update();
  }

  void setApiIslem(bool value) {
    bApiIslem.value = value;
    update();
  }

  void setKullaniciKaydiBasarili(bool value) {
    bKullaniciKaydiBasarili.value = value;
    update();
  }

  void startDialog({
    String text = "Lütfen Bekleyin.",
  }) {
    Get.defaultDialog(
      title: text,
      //backgroundColor: Colors.transparent,
      barrierDismissible: false,
      content: CircularProgressIndicator(backgroundColor: Colors.deepOrange),
    );
  }

  Future<void> getDoctorList() async {
    isLoading.value = true;
    try {
      final response = await APIService.doktorlariGetir();
      doctorList.assignAll(response);
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
     setLoading(false);
  }

  Future<List<Doctor>> matchDoctors(String symptom) async {
    setLoading(true);
    try {
      final response = await APIService.matchDoctors(symptom);
      return response;
    } catch (error) {
      print(error);
      // Hata oluştuğunda setLoading(false) metodunu çağırın
      setLoading(false);
      rethrow;
    } finally {
      setLoading(false);
    }
  }
  void stopDialog() {
    Get.back();
  }

  Future fetchStr() async {
    setLoading(true);
    await new Future.delayed(const Duration(seconds: 3), () {});
    setLoading(false);
  }

  // Future<void> oneSignalInit() async {
  //   await OneSignalService.getInstance();
  // }

  void validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      isValidEmail.value = false;
    } else {
      isValidEmail.value = true;
    }
  }

  void validatePassword(String value) {
    if (value.length < 6) {
      isValidPassword.value = false;
    } else {
      isValidPassword.value = true;
    }
  }
}
