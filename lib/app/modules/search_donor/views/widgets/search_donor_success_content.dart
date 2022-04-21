import 'package:blood_distirbution/app/modules/search_donor/controllers/search_donor_controller.dart';
import 'package:blood_distirbution/app/modules/search_donor/views/widgets/user_card.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class SearchDonorSuccessContent extends StatelessWidget {
  SearchDonorSuccessContent({Key? key}) : super(key: key);
  var controller = Get.find<SearchDonorController>();
  String? namaLengkap;
  @override
  Widget build(BuildContext context) {
    Widget actionButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: successColor,
                  padding: EdgeInsets.all(12),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  controller.updateLocation();
                  Get.snackbar(
                    "Update",
                    "Lokasi Berhasil di Update",
                    backgroundColor: successColor,
                    colorText: backgroundColor,
                  );
                },
                child: Text("Update Lokasi")),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding: EdgeInsets.all(12),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: "Apakah yakin ingin kembali ?",
                    middleText:
                        "Anda akan diarahkan ke halaman pencarian donor darah, dan pencarian saat ini akan disimpan ke history pencarian",
                    titlePadding: EdgeInsets.only(
                        top: 30,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: defaultMargin),
                    titleStyle: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                    middleTextStyle: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                    contentPadding: EdgeInsets.only(
                        top: defaultMargin,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: 30),
                    cancel: Container(
                      margin: EdgeInsets.only(right: 15, top: defaultMargin),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.SEARCH_DONOR);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                            shape: StadiumBorder(),
                            primary: primaryColor,
                          ),
                          child: Text("Batal")),
                    ),
                    confirm: Container(
                      margin: EdgeInsets.only(left: 15, top: defaultMargin),
                      child: ElevatedButton(
                          onPressed: () {
                            controller.simpanRequest();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                            shape: StadiumBorder(),
                            primary: successColor,
                          ),
                          child: Text("OK")),
                    ),
                  );
                },
                child: Text("Kembali")),
          ),
        ],
      );
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
        future: controller.getUser(),
        builder: (context, snapshot) {
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
            Map<String, dynamic>? user = snapshot.data!.data();
            var done =  (user!['status'] == "done") ? true : false;
            
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: defaultMargin, right: defaultMargin, top: 70),
                  padding: EdgeInsets.all(defaultMargin),
                  // height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          color: done ? successColor : primaryColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      done
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Berhasil Mendapatkan Pendonor",
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: semiBold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                              "Menunggu Pendonor !",
                              style: primaryTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: semiBold,
                                color: primaryColor,
                              ),
                            )),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 1,
                        color: done ? successColor : primaryColor,
                      ),
                      // SizedBox(height: defaultMargin,),
                      Text(
                        "Nama : ${user['namaLengkap']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Alamat : ${user['lokasi']['alamat']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Kebutuhan saat ini : ${user['permintaan'].toString()} kantong darah",
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Golongan Darah : ${user['golongan']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Divider(
                        color: done ? successColor : primaryColor,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      done
                          ? FutureBuilder<List<Object?>>(
                              future: controller.dataDonatur(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var donatur = snapshot.data;
                                  return Column(
                                    children: [
                                      Text(
                                        "Mendapatkan ${donatur!.length} Responden",
                                        style: primaryTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: semiBold,
                                          color: successColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: donatur.map((e) {
                                          Map<String, dynamic> user =
                                              e as Map<String, dynamic>;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nama : ${user['namaLengkap']}",
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 15,
                                                        color: successColor),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Nomor Telepon : ${user['nomorTelepon']}",
                                                    style: primaryTextStyle
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color:
                                                                successColor),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller.copyText(user[
                                                            'nomorTelepon']);
                                                      },
                                                      child: Icon(
                                                        Icons.copy,
                                                        size: 20,
                                                      ))
                                                ],
                                              ),
                                              Text(
                                                "Jumlah Darah : 1 Kantong Darah",
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontSize: 15,
                                                        color: successColor),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              })
                          : SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                actionButton(),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: defaultMargin,
                      right: defaultMargin,
                      top: 20,
                      bottom: 70),
                  padding: EdgeInsets.all(defaultMargin),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: successColor)),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        "User In Range",
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                          color: successColor,
                        ),
                      )),
                      Divider(
                        thickness: 1,
                        color: successColor,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      FutureBuilder<List<Object?>>(
                          future: controller.dataUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                          "Belum ada data",
                                          style: primaryTextStyle.copyWith(
                                              fontWeight: medium, fontSize: 18),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: user.map((e) {
                                      var data = e as Map<String, dynamic>;
                                      return UserCard(
                                        nama: "${data['namaLengkap']}",
                                        nomorTelepon: "${data['nomorTelepon']}",
                                        jarak: data['jarak'],
                                        golonganDarah: data['golonganDarah'],
                                      );
                                    }).toList());
                            } else {
                              print(snapshot.data);
                              return Center(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Belum ada data",
                                    style: primaryTextStyle.copyWith(
                                        fontWeight: medium, fontSize: 18),
                                  ),
                                ),
                              );
                            }
                          })
                    ],
                  ),
                ),
              ],
            );
          } else {
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
        });
  }
}
