import 'package:blood_distirbution/app/modules/blood_donor/views/widgets/history_card.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

import 'request_card.dart';

class ContentBloodDonor extends StatelessWidget {
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
          RequestCard(),
          RequestCard(),
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
