import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User 1",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18,),
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  color: primaryColor,
                  height: 10,
                  thickness: 2,
                ),
                Text(
                  "2 kantong darah",
                  style: primaryTextStyle.copyWith(
                      fontSize: 18,),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 75,
              width: 75,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "SIAP DONOR",
                  style: primaryTextStyle.copyWith(
                      fontSize: 13, fontWeight: bold, color: backgroundColor),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
