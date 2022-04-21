
import 'package:blood_distirbution/app/modules/profile/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                // child: Text(
                //   "${fullName}",
                //   style: primaryTextStyle.copyWith(
                //       fontSize: 18, fontWeight: medium),
                // ),
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.showButton.value = true;
                    } else {
                      controller.showButton.value = false;
                    }
                  },
                  controller: controller.namaLengkap,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "${fullName}",
                      hintStyle: primaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium)),
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
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.showButton.value = true;
                      } else {
                        controller.showButton.value = false;
                      }
                    },
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1960),
                          lastDate: DateTime.now());

                      if (date != null) {
                        controller.showButton.value = true;
                        print(
                            date); //pickedDate output format => 2021-03-10 00:00:00.000
                        String getDate = DateFormat('dd-MM-yyyy').format(date);
                        controller.tanggalLahir.value = getDate;
                      } else {
                        controller.showButton.value = false;
                      }
                    },
                    decoration: InputDecoration(
                        hintStyle: primaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: medium),
                        hintText: controller.tanggalLahir.value.isEmpty
                            ? '${tanggalLahir}'
                            : controller.tanggalLahir.value,
                        border: InputBorder.none),
                  )),
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
                child: DropdownSearch(
                  // showAsSuffixIcons: false,
                  mode: Mode.DIALOG,
                  showClearButton: true,
                  onChanged: (value) {
                    if (value != null) {
                      controller.golonganDarah.value = value.toString();
                      controller.showButton.value = true;
                    } else {
                      controller.showButton.value = false;
                    }
                  },
                  items: ["A", "B", "AB", "O"],
                  dropdownSearchDecoration: InputDecoration(
                      hintText: "${golonganDarah}",
                      hintStyle: primaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium),
                      border: InputBorder.none),
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
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.showButton.value = true;
                    } else {
                      controller.showButton.value = false;
                    }
                  },
                  controller: controller.username,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "${user}",
                      hintStyle: primaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: medium)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget telepon(telepon) {
      return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Telepon",
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
                  "${telepon}",
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
            onPressed: () {
              controller.updateProfile();
            },
            child: (controller.isLoading.value)
                ? CircularProgressIndicator(
                    color: backgroundColor,
                  )
                : Text(
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
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150),
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic>? user = snapshot.data!.data()!;
                return Obx(() => Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        fullName("${user['namaLengkap']}"),
                        tanggalLahir("${user['tanggalLahir']}"),
                        golonganDarah("${user['golonganDarah']}"),
                        username("${user['username']}"),
                        telepon("${user['nomorTelepon']}"),
                        SizedBox(
                          height: 20,
                        ),
                        controller.showButton.value
                            ? updateButton()
                            : SizedBox()
                      ],
                    ));
              } else {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 150),
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                );
              }
            }));
  }
}
