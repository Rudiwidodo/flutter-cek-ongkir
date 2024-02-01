import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../app/data/models/province_model.dart';
import '../app/modules/home/controllers/home_controller.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: type == "Asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          try {
            final respnose = await http.get(
              url,
              headers: {"key": "ace05f1d065ff6a0266be36209a120c6"},
            );
            var data = json.decode(respnose.body) as Map<String, dynamic>;
            var statusCode = data["rajaongkir"]["status"]["code"];
            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }
            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;
            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            print(e);
            return List<Province>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            if (type == "Asal") {
              controller.hiddenKotaAsal.value = false;
              controller.provAsalId.value = int.parse(value.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanId.value = int.parse(value.provinceId!);
            }
          } else {
            if (type == "Asal") {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "Cari provinsi",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
