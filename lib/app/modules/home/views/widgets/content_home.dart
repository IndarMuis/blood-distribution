import 'package:blood_distirbution/app/modules/home/views/widgets/card_menu.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';

import '../../../../../theme.dart';

class ContentHome extends StatelessWidget {
  const ContentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () async {
                    LocationPermission permission =
                        await Geolocator.checkPermission();
                    if (permission == LocationPermission.denied ||
                        permission == LocationPermission.deniedForever) {
                      LocationPermission asked =
                          await Geolocator.requestPermission();
                      print("Permission not given");
                    } else {
                      Get.toNamed(Routes.BLOOD_DONOR);
                    }
                  },
                  child: CardMenu(
                    menuName: "Blood Donors",
                    menuImage: "assets/donate.png",
                  )),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  LocationPermission permission =
                      await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied ||
                      permission == LocationPermission.deniedForever) {
                    LocationPermission asked =
                        await Geolocator.requestPermission();
                    print("Permission not given");
                  } else {
                    Get.toNamed(Routes.SEARCH_DONOR);
                  }
                },
                child: CardMenu(
                  menuName: "Find Donors",
                  menuImage: "assets/search.png",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                child: CardMenu(
                  menuName: "Profile",
                  menuImage: "assets/user_red.png",
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ABOUT);
                },
                child: CardMenu(
                  menuName: "About",
                  menuImage: "assets/info.png",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}