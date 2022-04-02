import 'package:blood_distirbution/app/data/models/user_model.dart';
import 'package:blood_distirbution/app/modules/profile/controllers/profile_controller.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class AppbarProfile extends GetView<ProfileController> {
  const AppbarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget actionButton() {
      return Container(
        height: 90,
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                    ;
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: backgroundColor,
                  )),
              GestureDetector(
                  onTap: () {
                    // Get.offAndToNamed(Routes.LOGIN);
                    Get.defaultDialog(
                      onConfirm: () {
                        controller.auth.signOut();
                        Get.offAndToNamed(Routes.LOGIN);
                      },
                      onCancel: () {},
                      title: "Sign Out",
                      titlePadding: EdgeInsets.all(defaultMargin),
                      titleStyle: primaryTextStyle.copyWith(
                          fontSize: 25, fontWeight: bold),
                      middleText: "Keluar dari aplikasi ?",
                      middleTextStyle: primaryTextStyle.copyWith(
                          fontSize: 20, fontWeight: semiBold),
                      contentPadding: EdgeInsets.all(30),
                      confirmTextColor: backgroundColor,
                      cancelTextColor: primaryColor,
                      backgroundColor: backgroundColor,
                      buttonColor: primaryColor,
                    );
                  },
                  child: Icon(
                    Icons.logout,
                    size: 30,
                    color: backgroundColor,
                  ))
            ],
          ),
        ),
      );
    }

    Widget title(String namaLengkap) {
      return Column(children: [
        Image.asset(
          "assets/user.png",
          width: 110,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${namaLengkap}",
          style: primaryTextStyle.copyWith(
              color: Colors.white, fontSize: 25, fontWeight: extraBold),
        ),
      ]);
    }

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2 - 20,
          width: double.infinity,
          padding: EdgeInsets.all(defaultMargin),
          decoration: BoxDecoration(
              color: primaryColor,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor,
                    primaryColor.withOpacity(0.7),
                  ])),
        ),
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: controller.main(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  controller.isLoading.value) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 150),
                    child: CircularProgressIndicator(
                      color: backgroundColor,
                    ),
                  ),
                );
              } else {
                var user = snapshot.data!.data()!;
                return Column(
                  children: [actionButton(), title("${user['namaLengkap']}")],
                );
              }
            })
      ],
    );
  }
}
