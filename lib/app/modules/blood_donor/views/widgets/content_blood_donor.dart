import 'package:blood_distirbution/app/modules/blood_donor/controllers/blood_donor_controller.dart';
import 'package:blood_distirbution/app/modules/blood_donor/views/widgets/history_card.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'request_card.dart';

class ContentBloodDonor extends GetView<BloodDonorController> {
  const ContentBloodDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "REQUEST BLOOD",
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
          SizedBox(
            height: 5,
          ),
          controller.isLoading.value
              ? Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : FutureBuilder<List<Object?>>(
                  future: controller.dataRequests(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      var user = snapshot.data;
                      return Column(
                          children: user!.map((e) {
                        var data = e as Map<String, dynamic>;
                          var number = "${data['nomor telepon']}";
                        return RequestCard(
                          nama: "${data['namaLengkap']}",
                          golonganDarah: '${data['golongan']}',
                          jumlahDarah: '${data['permintaan']}',
                          onTap: () async{
                            FlutterPhoneDirectCaller.callNumber(number);
                          },
                        );
                      }).toList());
                    } else {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
          SizedBox(
            height: 20,
          ),
          Text(
            "DONORS HISTORY",
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
          SizedBox(
            height: 5,
          ),
          HistoryCard(),
          HistoryCard(),
          HistoryCard(),
        ],
      ),
    );
  }
}
