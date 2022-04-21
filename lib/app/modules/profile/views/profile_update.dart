import 'package:blood_distirbution/app/modules/profile/controllers/profile_controller.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileUPdate extends GetView<ProfileController> {
  const ProfileUPdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin:
            EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update Your Profile",
              style:
                  primaryTextStyle.copyWith(fontSize: 30, fontWeight: medium),
            ),
          ],
        ),
      );
    }

    Widget fullNameInput(String namaLengkap) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Nama Lengkap",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller.namaLengkap,
          validator: (value) {
            if (value!.isEmpty) {
              return "Form must be filled";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: "${namaLengkap}",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget tanggalLahir(String tanggalLahir) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Tanggal Lahir",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Obx(() => TextField(
              readOnly: true,
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1960),
                    lastDate: DateTime.now());

                if (date != null) {
                  print(
                      date); //pickedDate output format => 2021-03-10 00:00:00.000
                  String getDate = DateFormat('dd-MM-yyyy').format(date);
                  controller.tanggalLahir.value = getDate;
                }
              },
              decoration: InputDecoration(
                hintStyle: primaryTextStyle.copyWith(fontWeight: light),
                contentPadding: EdgeInsets.all(defaultMargin),
                hintText: controller.tanggalLahir.value.isEmpty
                    ? '${tanggalLahir}'
                    : controller.tanggalLahir.value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )),
      ]);
    }

    Widget golonganDarahInput(String golonganDarah) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Golongan Darah",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        DropdownSearch(
          mode: Mode.DIALOG,
          showClearButton: true,
          onChanged: (value) {
            controller.golonganDarah.value = value.toString();
          },
          items: ["A", "B", "AB", "O"],
          dropdownSearchDecoration: InputDecoration(
              hintText: "${golonganDarah}",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: defaultMargin),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ]);
    }

    Widget usernameInput(String username) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Username",
          style: primaryTextStyle.copyWith(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller.username,
          onChanged: (value) {
            print(value);
          },
          decoration: InputDecoration(
            hintText: "${username}",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget buttonProcess() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () async {},
                child: Text(
                  "Batal",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, color: backgroundColor, fontWeight: medium),
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: successColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () async {},
                child: Text(
                  "Update",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, color: backgroundColor, fontWeight: medium),
                )),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          children: [
            Align(alignment: Alignment.topCenter, child: header()),
            SizedBox(
              height: 60,
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 40),
              margin: EdgeInsets.only(
                  left: defaultMargin, right: defaultMargin, bottom: 30),
              // height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 4,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: controller.main(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: successColor,
                        ),
                      );
                    } else {
                      Map<String, dynamic>? user = snapshot.data!.data();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          fullNameInput(user!['namaLengkap']),
                          SizedBox(
                            height: 20,
                          ),
                          usernameInput(user['username']),
                          SizedBox(
                            height: 20,
                          ),
                          tanggalLahir(user['tanggalLahir']),
                          SizedBox(
                            height: 20,
                          ),
                          golonganDarahInput(user['golonganDarah']),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          buttonProcess(),
                        ],
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
