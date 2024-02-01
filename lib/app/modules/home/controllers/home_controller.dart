import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uas_cek_ongkir/app/data/models/courier_model.dart';

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenKotaTujuan = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurirType = "";

  late TextEditingController beratController;

  double beratSatuan = 0.0;
  double beratInput = 0.0;
  String satuan = "gram";

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

    final response = await http.post(
      url,
      body: {
        "origin": "${kotaAsalId}",
        "destination": "${kotaTujuanId}",
        "weight": "${beratSatuan}",
        "courier": "${kurirType}"
      },
      headers: {
        "content-type": "application/x-www-form-urlencoded",
        "key": "ace05f1d065ff6a0266be36209a120c6"
      },
    );

    var data = json.decode(response.body) as Map<String, dynamic>;
    var results = data['rajaongkir']['results'];

    var listKurir = Courier.fromJsonList(results);
    var kurir = listKurir[0];

    Get.defaultDialog(
      contentPadding: EdgeInsets.all(10),
      title: kurir.name,
      content: Column(
        children: kurir.costs
            .map(
              (e) => ListTile(
                title: Text("${e.service}"),
                subtitle: Text("Rp. ${e.cost[0].value}"),
                trailing: Text(kurirType == "pos"
                    ? "${e.cost[0].etd}"
                    : "${e.cost[0].etd} HARI"),
              ),
            )
            .toList(),
      ),
    );
  }

  void ubahBerat(String value) {
    beratInput = double.tryParse(value) ?? 0.0;
    switch (satuan) {
      case "ton":
        beratSatuan = beratInput * 1000000;
        break;
      case "kwintal":
        beratSatuan = beratInput * 100000;
        break;
      case "ons":
        beratSatuan = beratInput * 100;
        break;
      case "kg":
        beratSatuan = beratInput * 1000;
        break;
      case "gram":
        beratSatuan = beratInput;
      default:
        beratSatuan = beratInput;
    }
    print("${beratSatuan} gram");
  }

  void ubahSatuan(String value) {
    switch (value) {
      case "ton":
        beratSatuan = beratInput * 1000000;
        break;
      case "kwintal":
        beratSatuan = beratInput * 100000;
        break;
      case "ons":
        beratSatuan = beratInput * 100;
        break;
      case "kg":
        beratSatuan = beratInput * 1000;
        break;
      case "gram":
        beratSatuan = beratInput;
      default:
        beratSatuan = beratInput;
    }

    satuan = value;
    print("${beratSatuan} gram");
  }

  @override
  void onInit() {
    beratController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    beratController.dispose();
    super.onClose();
  }
}
