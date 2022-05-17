import 'package:blood_distirbution/app/modules/profile/views/widgets/content_profile.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import 'widgets/appbar_profile.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AppbarProfile(),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "PROFILE",
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: extraBold),
                  ),
                ),
              ),
            ],
          ),
          ContentProfile(),
        ]),
      ),
    );
  }
}
