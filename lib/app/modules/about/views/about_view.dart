import 'package:blood_distirbution/app/modules/about/controllers/about_controller.dart';
import 'package:blood_distirbution/app/modules/about/views/widgets/appbar_about_donor.dart';
import 'package:blood_distirbution/app/modules/about/views/widgets/content_about_donor.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';



class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
                children: [
                  AppbarAboutDonor(),
                  SizedBox(
                    height: 15,
                  ),
                  ContentAboutDonor()
                  
                 ],
              )),
    );
  }
}
