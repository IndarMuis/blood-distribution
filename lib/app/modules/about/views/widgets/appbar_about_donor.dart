import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppbarAboutDonor extends StatelessWidget {
  const AppbarAboutDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.4,
      padding: EdgeInsets.all(defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(300, 70),
            bottomRight: Radius.elliptical(300, 70),
          )),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed(Routes.HOME);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: backgroundColor,
              ),
            ),
          ),
          Image.asset("assets/info.png", width: 70,),
          SizedBox(height: 15,),
          Text(
            "ABOUT DONORS",
            style: primaryTextStyle.copyWith(
                color: backgroundColor, fontSize: 30, fontWeight: bold),
          )
        ],
      ),
    );
  }
}
