import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject_iq/Custom_widget.dart';

class InternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxString connectstates = ''.obs;
  final RxString Networkstatus = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    _connectivity.onConnectivityChanged.listen(Updateconnectionstatus);
    super.onInit();
  }

  void Updateconnectionstatus(List<ConnectivityResult> ConnectivityResultList) {
    if (ConnectivityResultList.contains(ConnectivityResult.mobile)) {
      print("mobileinternet");
      connectstates.value = "Mobile internet";
      Networkstatus.value = "1";
      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }

      Get.back();
    } else if (ConnectivityResultList.contains(ConnectivityResult.vpn)) {
      print("VPN");
      connectstates.value = "VPN";
      Networkstatus.value = "1";
      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }

      Get.back();
    } else if (ConnectivityResultList.contains(ConnectivityResult.wifi)) {
      print("wifi");
      connectstates.value = "wifi";
      Networkstatus.value = "1";
      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }

      Get.back();
    } else if (ConnectivityResultList.contains(ConnectivityResult.none)) {
      print("offline");
      connectstates.value = "offline";
      Networkstatus.value = "2";
      // Get.snackbar("No Internet", "Connect to  Internet to proceed",
      //     backgroundColor: Colors.red,
      //     duration: Duration(days: 1),
      //     colorText: mycolor3,
      //     icon: Icon(
      //       Icons.wifi_off,
      //       color: Colors.grey,
      //     ));
      if (!Get.isDialogOpen!) {
        Get.defaultDialog(
            title: "No Internet!",
            middleText: "Connect to the Internet to proceed.",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            middleTextStyle: const TextStyle(color: Colors.black),
            barrierDismissible:
                false, // Prevent dismissing the dialog without action
            radius: 8,
            content: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/nointernet.png"))),
                ),
                Text("Please check your internet connection")
              ],
            ),
            confirm: MyButton(
              height: 30,
              width: 100,
              text: "Try again",
              onPressed: () {
                Get.back();
              },
            ));
      }
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      connectstates.value = "Something wnt wrong";
    }
  }
}
