import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_cek_ongkir/widgets/berat.dart';

import '../../../../widgets/dropdown_city.dart';
import '../../../../widgets/dropdown_province.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongkos Kirim'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Provinsi(
              type: "Asal",
            ),
            Obx(
              () => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : Kota(
                      type: "Asal",
                      provId: controller.provAsalId.value,
                    ),
            ),
            Provinsi(
              type: "Tujuan",
            ),
            Obx(
              () => controller.hiddenKotaTujuan.isTrue
                  ? SizedBox()
                  : Kota(
                      type: "Tujuan",
                      provId: controller.provTujuanId.value,
                    ),
            ),
            Berat(),
            DropdownSearch<Map<String, dynamic>>(
              mode: Mode.MENU,
              items: [
                {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                {"code": "tiki", "name": "Titipan Kilat (TIKI)"},
                {
                  "code": "pos",
                  "name": "Perusahaan Opsional Surat (POS Indonesia)"
                },
              ],
              label: "Pilih Kurir",
              onChanged: (value) {
                if (value != null) {
                  controller.hiddenButton.value = false;
                  controller.kurirType = value['code'];
                } else {
                  controller.hiddenButton.value = true;
                }
              },
              itemAsString: (value) => "${value['name']}",
              popupItemBuilder: (context, item, isSelected) => Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "${item['name']}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
            ),
            Obx(
              () => controller.hiddenButton.isTrue ||
                      controller.provAsalId == 0 ||
                      controller.provTujuanId == 0
                  ? Container(
                      child: Text("Lengkapi data-data diatas !"),
                    )
                  : ElevatedButton(
                      onPressed: () => controller.ongkosKirim(),
                      child: Text("Cek Ongkos Kirim"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
