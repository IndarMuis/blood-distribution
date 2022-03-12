import 'package:blood_distirbution/app/modules/search_donor/views/widgets/appbar_search_donor.dart';
import 'package:blood_distirbution/app/modules/search_donor/views/widgets/content_search_donor.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_donor_controller.dart';

class SearchDonorView extends GetView<SearchDonorController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          children: [
            AppbarSearchDonor(),
            SizedBox(height: 20,),
            ContentSearchDonor()
          ],
        )
      ),
    );
  }
}
