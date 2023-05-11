import 'package:flutter/material.dart';

class MyConstant {
//API
  static bool development = false;
  // static String kUygulamaVersiyonu = "V.1.1.1";
  // static String ip = "localhost:51743";

  // static String ip = "192.168.1.32/VeresiyeDefteri";
  static String ip = "http://192.168.1.37/";

  
 /*  static String apiForgatPasswordUrl =
      "http://" + ip + "/api/User/ForgotPassword/";

  static String apiUserUrl = "http://" + ip + "/api/User"; */

//API

  //Snackbar

  static int snackDuration = 3;
//static Color snackBackgroundColorError = color: Colors.red[100];
  static Icon snackIconError = Icon(Icons.error, color: Colors.red);
  static Icon snackIconSucces = Icon(Icons.check, color: Colors.green);
  //static Color snackBackgroundColorSucces = Colors.green[100];
  static Icon snackIconNotification = Icon(Icons.alarm, color: Colors.grey);

  
  //static Color logoColorRGB = Color.fromARGB(255, 238, 39, 13);

  //Snackbar

  static Color myColor = Colors.blue;
  static Icon myIcon = Icon(
    Icons.search,
    color: Colors.red,
  );
  static TextStyle myStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green);

  static Color butonColor = Colors.blue;


}

const String SUCCESS_MESSAGE = " You will be contacted by us very soon.";

const userLoginApi = "login";
const userSignupApi = "signup";

// Shared Preference keys
const kDeviceName = "device_name";
const kDeviceUDID = "device_id";