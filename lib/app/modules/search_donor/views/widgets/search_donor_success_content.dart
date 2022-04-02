import 'package:blood_distirbution/app/modules/home/views/home_view.dart';
import 'package:blood_distirbution/app/modules/search_donor/controllers/search_donor_controller.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/state_manager.dart';

class SearchDonorSuccessContent extends StatelessWidget {
  SearchDonorSuccessContent({Key? key}) : super(key: key);
  var controller = Get.find<SearchDonorController>();
  @override
  Widget build(BuildContext context) {
    Widget actionButton() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding: EdgeInsets.all(15),
                  shape: StadiumBorder(),
                ),
                onPressed: () {},
                child: Text("Batalkan Permintaan")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: successColor,
                  padding: EdgeInsets.all(15),
                  shape: StadiumBorder(),
                ),
                onPressed: () {},
                child: Text("Refresh Location")),
          ],
        ),
      );
    }

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
        future: controller.getUser(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator(
              color: successColor,
            );
          }
          Map<String, dynamic>? user = snapshot.data!.data();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: EdgeInsets.only(top: 200),
              child: CircularProgressIndicator(
                color: successColor,
              ),
            );
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: defaultMargin, right: defaultMargin, top: 70),
                  padding: EdgeInsets.all(defaultMargin),
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: successColor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                          child: Text(
                        "Menunggu Pendonor !",
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
                      // SizedBox(height: defaultMargin,),
                      Text(
                        "Nama : ${user!['namaLengkap']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Tempat Lahir : ${user['tempatLahir']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Tanggal Lahir : ${user['tanggalLahir']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Permintaan : ${user['permintaan']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Golongan Darah : ${user['golongan']}",
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                actionButton()
              ],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 200),
              child: CircularProgressIndicator(
                color: successColor,
              ),
            );
          }
        });
  }
}
