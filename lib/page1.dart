import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';

import 'controller.dart';

class Pageone extends StatefulWidget {
  const Pageone({super.key});

  @override
  State<Pageone> createState() => _PageoneState();
}

class _PageoneState extends State<Pageone> {
  InternetController Net = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton.icon(
            onPressed: () {},
            label: Text("Homepage"),
            icon: Icon(Icons.wifi),
          ),
        ),
        Obx(
          () => Text(Net.connectstates.value),
        ),
        Obx(() => Net.Networkstatus.value == "1"
            ? Icon(
                Icons.wifi,
                color: Colors.green,
              )
            : Net.Networkstatus.value == "2"
                ? Icon(
                    Icons.wifi_off,
                    color: Colors.red,
                  )
                : Text("data")),
        Obx(
          () => Text(Net.Networkstatus.value),
        )
      ],
    ));
  }
}
