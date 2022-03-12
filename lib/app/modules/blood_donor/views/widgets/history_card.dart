import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: successColor, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "USER 1",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "11-01-2022",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "2 kantong darah",
                  style:
                      primaryTextStyle.copyWith(fontSize: 18, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Image.asset("assets/success.png", width: 40, height: 40,)
        ],
      ),
    );
  }
}
