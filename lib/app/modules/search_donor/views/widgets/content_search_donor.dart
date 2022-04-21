import 'package:blood_distirbution/app/modules/search_donor/controllers/search_donor_controller.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentSearchDonor extends StatelessWidget {
  ContentSearchDonor({Key? key}) : super(key: key);
  final controller = Get.find<SearchDonorController>();
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
              controller.banyakDarah.value = int.parse(value.toString());
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

    Widget buttonProcess() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Get.defaultDialog(
                  backgroundColor: backgroundColor,
                  titlePadding: EdgeInsets.only(
                    top: 25,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  title: "History Requests",
                  titleStyle: primaryTextStyle.copyWith(
                    fontSize: 22,
                    fontWeight: semiBold,
                  ),
                  buttonColor: successColor,
                  cancelTextColor: successColor,
                  textCancel: "OK",
                  onCancel: () {},
                  contentPadding: EdgeInsets.only(
                      top: defaultMargin,
                      left: defaultMargin,
                      right: defaultMargin,
                      bottom: 25),
                  content: FutureBuilder<List<Object?>>(
                      future: controller.getHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: successColor,
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data;

                          return (data!.isEmpty)
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Belum ada data",
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: medium, fontSize: 18),
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: data.map((e) {
                                    var user = e as Map<String, dynamic>;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nama : ${user['namaLengkap']}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18, fontWeight: medium),
                                        ),
                                        Text(
                                          "Nomor Telepon : ${user['nomorTelepon']}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18, fontWeight: medium),
                                        ),
                                        Text(
                                          "Golongan : ${user['golongan']}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18, fontWeight: medium),
                                        ),
                                        Text(
                                          "Jumlah Permintaan : ${user['permintaan']}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18, fontWeight: medium),
                                        ),
                                        Text(
                                          "Jumlah Pendonor : ${user['jumlah pendonor']}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18, fontWeight: medium),
                                        ),
                                        Text(
                                          "Tanggal : ${user['tanggal']}",
                                          style: primaryTextStyle.copyWith(
                                              fontSize: 18, fontWeight: medium),
                                        ),
                                        Divider(
                                          color: successColor,
                                          thickness: 1,
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: successColor,
                          ),
                        );
                      }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 19),
              height: 55,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Obx(() => (controller.isLoading.value)
                    ? CircularProgressIndicator(
                        color: backgroundColor,
                      )
                    : Text(
                        "History Requests",
                        style: primaryTextStyle.copyWith(
                          fontSize: 13,
                          color: primaryColor,
                          fontWeight: bold,
                        ),
                      )),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // print(controller.banyakDarah.value);
              // print(controller.golonganDarah.value);
              controller.searchDonor();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 19),
              height: 55,
              width: MediaQuery.of(context).size.width / 2.5,
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
                          fontSize: 13,
                          color: backgroundColor,
                          fontWeight: bold,
                        ),
                      )),
              ),
            ),
          ),
        ],
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
            height: 50,
          ),
          buttonProcess(),

          // Align(alignment: Alignment.bottomCenter, child: miniMap())
        ],
      ),
    );
  }
}
