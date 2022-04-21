import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String nama;
  final String jumlahDarah;
  final String golonganDarah;
  final String tanggal;
  final VoidCallback onTap;
  RequestCard(
      {required this.nama,
      required this.golonganDarah,
      required this.tanggal,
      required this.jumlahDarah,
      required this.onTap});

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
                  "${nama}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Golongan Darah: ${golonganDarah}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  color: primaryColor,
                  height: 10,
                  thickness: 1,
                ),
                Text(
                  "Tanggal: ${tanggal}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${jumlahDarah} Kantong Darah",
                  style: primaryTextStyle.copyWith(
                    fontSize: 17,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
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
