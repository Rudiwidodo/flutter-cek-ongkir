import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../app/data/models/city_model.dart';
import '../app/modules/home/controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    super.key,
    required this.provId,
    required this.type,
  });

  final int provId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: type == "Asal"
            ? "Kota / Kabupaten Asal"
            : "Kota / Kabupaten Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=${provId}");
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
            var models = City.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            print(e);
            return List<City>.empty();
          }
        },
        onChanged: (value) {
          if (value != null) {
            if (type == "Asal") {
              controller.kotaAsalId.value = int.parse(value.cityId!);
            } else {
              controller.kotaTujuanId.value = int.parse(value.cityId!);
            }
          } else {
            print("tidak ada kota yang dipilih");
          }
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "Cari Kota / Kabupaten",
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
              "${item.type} ${item.cityName}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
