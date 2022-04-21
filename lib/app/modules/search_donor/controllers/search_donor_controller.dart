import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class SearchDonorController extends GetxController {
  var golonganDarah = "".obs;
  var banyakDarah = 0.obs;
  var longitude = 0.0.obs;
  var latitude = 0.0.obs;
  var alltitude = 0.0.obs;

  var isLoading = false.obs;

  final requests = FirebaseFirestore.instance.collection('requests');
  final firestore = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore fire = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var exist = false.obs;

  @override
  void onInit() async {
    String uid = auth.currentUser!.uid;
    isLoading.value = true;
    // var check = await requests.doc(uid).get();
    // if (check.exists) {
    //   pint
    // }

    await requests.doc(uid).get().then(
        (value) => {(value.exists) ? exist.value = true : exist.value = false});
    print("On init");
    isLoading.value = false;
    // print(exist);
    super.onInit();
  }

  Future<List<Object?>> dataUser() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> data = [];

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever && allData.isNotEmpty) {
    } else {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((position) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
      });
      for (int i = 0; i < allData.length; i++) {
        var jarak = Geolocator.distanceBetween(
              latitude.value,
              longitude.value,
              allData[i]['lokasiTerkini']['latitude'],
              allData[i]['lokasiTerkini']['longitude'],
            ).round() /
            1000;
        await firestore.doc(allData[i]['uid']).update({"jarak": jarak});
        if (allData[i]['jarak'] < 20 &&
            !allData[i]['uid'].contains(auth.currentUser!.uid)) {
          data.add(allData[i]);
        }
      }
    }
    isLoading.value = false;
    data.sort((a, b) {
      // var sort = b['alltitude'].compareTo(a['alltitude']);
      // print(b['alltitude']);
      return a['jarak'].compareTo(b['jarak']);
    });
    return data;
  }

  void searchDonor() async {
    String uid = auth.currentUser!.uid;
    // LocationPermission permission = await Geolocator.checkPermission();

    isLoading.value = true;
    DocumentSnapshot<Map<String, dynamic>?> data =
        await firestore.doc(uid).get();
    Map<String, dynamic> user = data.data()!;

    if (golonganDarah.value != "" &&
        banyakDarah.value != "" &&
        golonganDarah.isNotEmpty &&
        banyakDarah.value != 0 &&
        !exist.value) {
      Position currentPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude.value = currentPostion.latitude;
      longitude.value = currentPostion.longitude;
      alltitude.value = currentPostion.altitude;

      try {
        List<Placemark> placemark =
            await placemarkFromCoordinates(latitude.value, longitude.value);
        var alamat = placemark[0].subLocality! + ', ' + placemark[0].locality!;
        print(placemark);
        await requests.doc(uid).set({
          "namaLengkap": user['namaLengkap'],
          "email": user['email'],
          "nomorTelepon": user['nomorTelepon'],
          "permintaan": banyakDarah.value,
          "lokasi": {
            "latitude": latitude.value,
            "longitude": longitude.value,
            "alamat": alamat,
          },
          "pendonor": [],
          "jarak": 0,
          "golongan": golonganDarah.value,
          "alltitude": alltitude.value,
          "status": "waiting",
          "uid": uid,
          "tanggal": DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()
        });

        isLoading.value = false;
        exist.value = true;
        Get.defaultDialog(
            title: "Berhasil",
            titlePadding:
                EdgeInsets.only(top: defaultMargin, bottom: defaultMargin),
            contentPadding: EdgeInsets.only(bottom: defaultMargin),
            titleStyle: primaryTextStyle.copyWith(fontSize: 25),
            confirm: Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    primary: successColor),
                onPressed: () {
                  Get.offAllNamed(Routes.SEARCH_DONOR);
                },
                child: Text(
                  "OK",
                  style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                      color: backgroundColor),
                ),
              ),
            ),
            backgroundColor: backgroundColor,
            confirmTextColor: backgroundColor,
            content: Image.asset(
              "assets/success.png",
              width: 100,
            ));
      } catch (e) {
        print(e.toString());
        isLoading.value = false;
        Get.snackbar('', '',
            colorText: backgroundColor,
            titleText: Text(
              'Error',
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: semiBold, color: backgroundColor),
            ),
            messageText: Text(
              'Mohon Periksa Kembali Inputan Anda',
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: semiBold, color: backgroundColor),
            ),
            backgroundColor: primaryColor.withOpacity(0.7),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3));
      }
    } else {
      isLoading.value = false;
      Get.snackbar('', '',
          colorText: backgroundColor,
          titleText: Text(
            'Error',
            style: primaryTextStyle.copyWith(
                fontSize: 17, fontWeight: semiBold, color: backgroundColor),
          ),
          messageText: Text(
            'Mohon Periksa Kembali Inputan Anda',
            style: primaryTextStyle.copyWith(
                fontSize: 17, fontWeight: semiBold, color: backgroundColor),
          ),
          backgroundColor: primaryColor.withOpacity(0.7),
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUser() async {
    String uid = await auth.currentUser!.uid;
    return requests.doc(uid).get();
  }

  Future<List<Object>> dataDonatur() async {
    String uid = await auth.currentUser!.uid;
    var dataReq = await requests.doc(uid).get();
    QuerySnapshot<Map<String, dynamic>> user = await firestore.get();
    final allData = user.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> dataDonatur = [];
    for (int i = 0; i < allData.length; i++) {
      var exist = dataReq['pendonor'].toString().contains(allData[i]['uid']);
      if (exist) {
        dataDonatur.add(allData[i]);
      }
    }
    print(dataDonatur.length);
    return dataDonatur;
  }

  void updateLocation() async {
    isLoading.value = true;
    Position currentPostion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    latitude.value = currentPostion.latitude;
    longitude.value = currentPostion.longitude;
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude.value, longitude.value);
    var alamat = placemark[0].name! +
        ', ' +
        placemark[0].subLocality! +
        ', ' +
        placemark[0].locality!;

    String uid = await auth.currentUser!.uid;
    await requests.doc(uid).update({
      "lokasi": {
        "latitude": latitude.value,
        "longitude": longitude.value,
        "alamat": alamat
      }
    });
    isLoading.value = false;
    print(isLoading.value);
  }

  Future<void> copyText(var text) async {
    await Clipboard.setData(ClipboardData(text: text.toString()));
    Get.snackbar(
      "Copy",
      "Successfully Copying",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: successColor.withOpacity(0.5),
      colorText: backgroundColor,
    );
  }

  void simpanRequest() async {
    String uid = await auth.currentUser!.uid;
    CollectionReference dataRequests = FirebaseFirestore.instance.collection('requests');
    FirebaseFirestore fire = FirebaseFirestore.instance;
    // QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore.get();
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    try {
      // var querySnapshot = await firestore.collection('requests');
      
      final allField = await dataRequests.doc(uid).get();
      print(allField['permintaan'] + allField['pendonor'].length);
      fire.collection('history').doc(DateFormat('dd-MM-yyyy - HH:mm:ss').format(DateTime.now()).toString()).set({
        "uid": allField['uid'],
        "namaLengkap": allField['namaLengkap'],
        "lokasi": {
          "latitude": allField['lokasi']['latitude'],
          "longitude": allField['lokasi']['longitude'],
          "alamat": allField['lokasi']['alamat']
        },
        "permintaan": allField['permintaan'] + allField['pendonor'].length,
        "jumlahDonatur": allField['pendonor'].length,
        "jarak": allField['jarak'],
        "nomorTelepon": allField['nomorTelepon'],
        "golongan": allField['golongan'],
        "email": allField['email'],
        "status": allField['status'],
        "pendonor": allField['pendonor'],
        "tanggal": allField['tanggal'],
      });
      await fire.collection('requests').doc(uid).delete();
      exist.value = false;
      Get.offAllNamed(Routes.SEARCH_DONOR);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Object?>> getHistory() async {
    isLoading.value = true;
    String uid = await auth.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fire
        .collection('history')
        .where('uid', isEqualTo: uid)
        .get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List dataHistory = [];
    for (int i=0; i < allData.length; i++) {
      dataHistory.add(allData[i]);
    }
     dataHistory.sort((a, b) {
      // var sort = b['alltitude'].compareTo(a['alltitude']);
      // print(b['alltitude']);
      return a['tanggal'].compareTo(b['tanggal']);
    });
    isLoading.value = false;
    return dataHistory;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
