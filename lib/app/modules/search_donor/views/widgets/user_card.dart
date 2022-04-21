import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String nama;
  final String nomorTelepon;
  final String golonganDarah;
  final double jarak;
  UserCard({Key? key, required this.nama, required this.nomorTelepon, required this.jarak, required this.golonganDarah}) : super(key: key);

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
                  "Nama : ${nama}",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Golongan Darah : ${golonganDarah}",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Telepon : ${nomorTelepon}",
                  style:
                      primaryTextStyle.copyWith(fontSize: 16, fontWeight: regular),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.location_history, size: 40,),
              SizedBox(height: 5,),
              Text((jarak < 1) ? "${jarak*1000} M" : "${jarak} KM")
            ],
          )
          // Image.asset("assets/success.png", width: 40, height: 40,)
        ],
      ),
    );
  }
}
