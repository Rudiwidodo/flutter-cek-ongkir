import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/home/controllers/home_controller.dart';

class Berat extends GetView<HomeController> {
  const Berat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: controller.beratController,
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Berat Barang",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                hintText: "cari satuan berat",
                border: OutlineInputBorder(),
              ),
              items: ["ton", "kuintal", "ons", "kg", "gram"],
              label: "Satuan Berat",
              selectedItem: "gram",
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          )
        ],
      ),
    );
  }
}
