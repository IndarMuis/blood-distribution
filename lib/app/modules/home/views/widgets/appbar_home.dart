import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget userCard() {
      return Container(
        height: 90,
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Hello, Indar",
                  style: primaryTextStyle.copyWith(
                      fontSize: 25, color: Colors.white, fontWeight: light),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: Image.asset("assets/user.png", height: 55, width: 55,)),
            ],
          ),
        ),
      );
    }

    Widget title() {
      return Column(
        children: [
        Image.asset("assets/logo.png", width: 110,),
        SizedBox(height: 10,),
        Text(
          "DONATE BLOOD",
          style: primaryTextStyle.copyWith(
              color: Colors.white, fontSize: 25, fontWeight: semiBold),
        ),
        Text(
          "''GIVE THE GIFT OF LIFE TO THE WORLD''",
          style: primaryTextStyle.copyWith(
              color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        )
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userCard(),
            title()
          ],
        )
      ],
    );
  }
}
