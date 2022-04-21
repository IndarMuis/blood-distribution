import 'package:blood_distirbution/app/modules/blood_donor/controllers/blood_donor_controller.dart';
import 'package:blood_distirbution/app/modules/blood_donor/views/widgets/history_card.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'request_card.dart';

class ContentBloodDonor extends GetView<BloodDonorController> {
  const ContentBloodDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "REQUEST BLOOD",
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
          SizedBox(
            height: 5,
          ),
          controller.isLoading.value
              ? Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : FutureBuilder<List<Object?>>(
                  future: controller.dataRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      var user = snapshot.data;
                      return (user!.isEmpty)
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Belum ada request",
                                  style: primaryTextStyle.copyWith(
                                      fontWeight: medium, fontSize: 18),
                                ),
                              ),
                            )
                          : Column(
                              children: user.map((e) {
                              var data = e as Map<String, dynamic>;
                              var number = "${data['nomorTelepon']}";
                              print(data['tanggal']);
                              return RequestCard(
                                nama: "${data['namaLengkap']}",
                                golonganDarah: '${data['golongan']}',
                                tanggal: "${data['tanggal']}",
                                jumlahDarah: '${data['permintaan']}',
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "Konfirmasi",
                                    middleText:
                                        "Apakah anda bersedia untuk melakukan donor darah?",
                                    middleTextStyle: primaryTextStyle,
                                    titleStyle: primaryTextStyle.copyWith(
                                        fontSize: 20, fontWeight: semiBold),
                                    buttonColor: successColor,
                                    actions: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Nomor Telepon :",
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 15,
                                                fontWeight: semiBold),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: defaultMargin,
                                                right: defaultMargin,
                                                bottom: defaultMargin),
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: successColor),
                                                borderRadius:
                                                    BorderRadius.circular(18)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  number.toString(),
                                                  style: primaryTextStyle
                                                      .copyWith(fontSize: 15),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .copyText(number);
                                                    },
                                                    child: Icon(Icons.copy)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Lokasi :",
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 15,
                                                fontWeight: semiBold),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              MapsLauncher.launchCoordinates(
                                                  data['latitude'],
                                                  data['longitude']);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: defaultMargin,
                                                  right: defaultMargin,
                                                  bottom: defaultMargin),
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: successColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Buka Map",
                                                    style: primaryTextStyle
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                  Icon(Icons.location_on)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      ElevatedButton(
                                          onPressed: () {
                                            Get.offAllNamed(Routes.BLOOD_DONOR);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(15),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            primary: primaryColor,
                                          ),
                                          child: Text("Batal")),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            print(data['uid']);
                                            controller.confirmRequest(id: data['uid']);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(15),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            primary: successColor,
                                          ),
                                          child: Text("Konfirmasi")),
                                      // ElevatedButton(onPressed: () {}, child: Text("action")),
                                    ],
                                    titlePadding: EdgeInsets.all(defaultMargin),
                                    contentPadding: EdgeInsets.only(
                                        bottom: defaultMargin,
                                        left: defaultMargin,
                                        right: defaultMargin),
                                  );
                                },
                              );
                            }).toList());
                    } else {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Belum ada request",
                            style: primaryTextStyle.copyWith(
                                fontWeight: medium, fontSize: 18),
                          ),
                        ),
                      );
                    }
                  },
                ),
          SizedBox(
            height: 20,
          ),
          Text(
            "DONORS HISTORY",
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
          SizedBox(
            height: 5,
          ),
          FutureBuilder<List<Object?>>(
            future: controller.historyRequest(),
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: successColor,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                var user = snapshot.data;
                return (user!.isEmpty)
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Belum ada request",
                            style: primaryTextStyle.copyWith(
                                fontWeight: medium, fontSize: 18),
                          ),
                        ),
                      )
                    : Column(
                        children: user.map((e) {
                        var data = e as Map<String, dynamic>;
                        return HistoryCard(
                            nama: '${data['namaLengkap']}',
                            jumlahDarah: '${data['permintaan']}',
                            tanggal: DateFormat('dd-MM-yyyy')
                                .format(DateTime.now()));
                      }).toList());
              } else {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Belum ada request",
                      style: primaryTextStyle.copyWith(
                          fontWeight: medium, fontSize: 18),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
