import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppbarProfile extends StatelessWidget {
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

    Widget title() {
      return Column(children: [
        Image.asset(
          "assets/user.png",
          width: 110,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Ismunandar Muis",
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
        Column(
          children: [actionButton(), title()],
        )
      ],
    );
  }
}
