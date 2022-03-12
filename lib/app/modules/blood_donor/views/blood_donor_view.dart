import 'package:blood_distirbution/app/modules/blood_donor/views/widgets/appbar_blood_donor.dart';
import 'package:blood_distirbution/app/modules/blood_donor/views/widgets/content_blood_donor.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/blood_donor_controller.dart';

class BloodDonorView extends GetView<BloodDonorController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          children: [
            AppbarBloodDonor(),
            SizedBox(height: 20,),
            ContentBloodDonor()
          ],
        ),
      ),
    );
  }
}
