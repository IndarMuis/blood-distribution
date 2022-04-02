import 'package:blood_distirbution/app/modules/home/views/home_view.dart';
import 'package:blood_distirbution/app/modules/search_donor/controllers/search_donor_controller.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/state_manager.dart';

class ContentSearchDonor extends StatelessWidget {
  ContentSearchDonor({Key? key}) : super(key: key);
  var controller = Get.find<SearchDonorController>();
  @override
  Widget build(BuildContext context) {
    Widget inputGolonganDarah() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Golongan darah yang dibutuhkan :",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownSearch(
            mode: Mode.DIALOG,
            showClearButton: true,
            onChanged: (value) {
              controller.golonganDarah.value = value.toString();
            },
            items: ["A", "B", "AB", "O"],
            dropdownSearchDecoration: InputDecoration(
                hintText: "Golongan Darah",
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: defaultMargin),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      );
    }

    Widget inputJumlahDarah() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Banyak darah yang dibutuhkan :",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownSearch(
            mode: Mode.DIALOG,
            showClearButton: true,
            onChanged: (value) {
              controller.banyakDarah.value = value.toString();
            },
            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
            dropdownSearchDecoration: InputDecoration(
                hintText: "Kantong Darah",
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: defaultMargin),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      );
    }

    Widget inputNomorTelepon() {
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nomor Telepon (WhatsApp) :",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
          controller: controller.inputNomorTelepon,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "082193XXXXX",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        ],
      );
    }

    Widget buttonProcess() {
      return GestureDetector(
        onTap: () {
          // print(controller.banyakDarah.value);
          // print(controller.golonganDarah.value);
          controller.searchDonor();
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: 10, horizontal: defaultMargin),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Obx(() => (controller.isLoading.value)
                ? CircularProgressIndicator(
                    color: backgroundColor,
                  )
                : Text(
                    "Cari Sukarelawan",
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      color: backgroundColor,
                      fontWeight: bold,
                    ),
                  )),
          ),
        ),
      );
    }

    Widget miniMap() {
      return Container(
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            "MINI MAP",
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(defaultMargin),
      child: Column(
        children: [
          inputGolonganDarah(),
          SizedBox(
            height: 20,
          ),
          inputJumlahDarah(),
          SizedBox(
            height: 20,
          ),
          inputNomorTelepon(),
          SizedBox(
            height: 50,
          ),
          buttonProcess(),
          
          // Align(alignment: Alignment.bottomCenter, child: miniMap())
        ],
      ),
    );
  }
}
