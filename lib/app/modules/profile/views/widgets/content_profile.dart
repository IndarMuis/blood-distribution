import 'package:blood_distirbution/app/data/models/user_model.dart';
import 'package:blood_distirbution/app/modules/home/views/widgets/card_menu.dart';
import 'package:blood_distirbution/app/modules/profile/controllers/profile_controller.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../../../../theme.dart';

class ContentProfile extends GetView<ProfileController> {
  const ContentProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget fullName(String fullName) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Full Name",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${fullName}",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget tanggalLahir(String tanggalLahir) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Tanggal Lahir",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${tanggalLahir}",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget golonganDarah(String golonganDarah) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Golongan Darah",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${golonganDarah}",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget username(String user) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Username",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${user}",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget password() {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Password",
                style: primaryTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "12345",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: medium),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget updateButton() {
      return Container(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () {},
            child: Text(
              "Update Profile",
              style: primaryTextStyle.copyWith(
                  fontSize: 20, color: backgroundColor),
            )),
      );
    }

    return Container(
        padding: EdgeInsets.only(
            bottom: defaultMargin, left: defaultMargin, right: defaultMargin),
        color: backgroundColor,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.main(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  controller.isLoading.value) {
                return Container(
                  margin: EdgeInsets.only(top: 150),
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic>? user = snapshot.data!.data()!;
                print(user['username']);
                print(user['tanggalLahir']);
                print(user['golonganDarah']);
                print(user['username']);
                print(snapshot.data!);
                return Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    fullName("${user['namaLengkap']}"),
                    tanggalLahir("${user['tanggalLahir']}"),
                    golonganDarah("${user['golonganDarah']}"),
                    username("${user['username']}"),
                    password(),
                    SizedBox(
                      height: 20,
                    ),
                    updateButton()
                  ],
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(top: 200),
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
            }));
  }
}
