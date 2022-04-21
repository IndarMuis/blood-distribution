import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class BloodDonorController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;
  var number = "".obs;
  var uid = "".obs;
  var lat = 0.0.obs;
  var lon = 0.0.obs;
  var permintaan = 0.obs;
  var idDonor = 1.obs;

  FirebaseFirestore fire = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore req = FirebaseFirestore.instance;

  Future<List<Object?>> dataRequests() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fire
        .collection('requests')
        .where('permintaan', isGreaterThanOrEqualTo: 1)
        .get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final reqUserId =
        querySnapshot.docs.map((doc) => doc.reference.id).toList();

    List<Map<String, dynamic>> data = [];

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
    } else {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((position) {
        latitude.value = position.latitude;
        longitude.value = position.longitude;
        // print(position.altitude);
      });
      print(allData.length);
      uid.value = await auth.currentUser!.uid;
      for (int i = 0; i < allData.length; i++) {
        lat.value = allData[i]['lokasi']['latitude'];
        lon.value = allData[i]['lokasi']['longitude'];
        // var id = allData[i]['pendonor ${idDonor.value}']['uid'];
        // var reqId = reqUserId[i];
        var jarak = await Geolocator.distanceBetween(
            latitude.value, longitude.value, lat.value, lon.value);
        var jarakKm = jarak.round().toInt() / 1000;
        // print(reqId);
        // print("UID ${uid.value}");
        // print(!uid.value.contains(reqId));
        var exist = await allData[i]['uid'].contains(uid.value);
        var donorExist = await allData[i]['pendonor'].contains(uid.value);
        print(allData[i]['pendonor']);
        print(uid.value);
        if (jarakKm < 20 && !exist && !donorExist) {
          // data.sort((a, b) {
          //   return a[i].compareTo(b[i]);
          // });
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

  Future<List<Object?>> historyRequest() async {
    uid.value = await auth.currentUser!.uid;
    isLoading.value = true;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fire
        .collection('requests')
        .where('pendonor', arrayContains: uid.value)
        .get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    QuerySnapshot<Map<String, dynamic>> history = await fire
        .collection('history')
        .where('pendonor', arrayContains: uid.value)
        .get();
    final historyReq = history.docs.map((doc) => doc.data()).toList();
    print(allData.isNotEmpty);
    List<Map<String, dynamic>> data = [];
    if (allData.isEmpty || historyReq.isNotEmpty) {
      print("masuk");
      for (int i = 0; i < allData.length; i++) {
        uid.value = await auth.currentUser!.uid;
        var exist = allData[i]['pendonor'].toString().contains(uid.value);
        if (exist) {
          data.add(allData[i]);
        }
      }
      for (int i = 0; i < historyReq.length; i++) {
        uid.value = await auth.currentUser!.uid;
        var exist = historyReq[i]['pendonor'].toString().contains(uid.value);
        if (exist) {
          data.add(historyReq[i]);
        }
      }

      return data;
    }
    else if (allData.isNotEmpty) {
      print("object");
      for (int i = 0; i < allData.length; i++) {
        uid.value = await auth.currentUser!.uid;
        var exist = allData[i]['pendonor'].toString().contains(uid.value);
        if (exist) {
          data.add(allData[i]);
        }
      }
    } else if (historyReq.isNotEmpty) {
      print("kdjkdjkdkjfkjdkjfd");
      for (int i = 0; i < historyReq.length; i++) {
        uid.value = await auth.currentUser!.uid;
        var exist = historyReq[i]['pendonor'].toString().contains(uid.value);
        if (exist) {
          data.add(historyReq[i]);
        }
      }
    } else {
      data = [];
    }
    print(data.length);
    isLoading.value = false;
    return data;
  }

  void confirmRequest({id}) async {
    try {
      uid.value = auth.currentUser!.uid;
      // var data = await fire.collection('users').doc(uid.value).get();
      // var dataPendonor = data.data();
      req.collection('requests').doc(id).get().then((value) async {
        // permintaan.value = await (value['permintaan']) - 1;
        // print(permintaan);
        print(idDonor.value);
        await req.collection('requests').doc(id).update({
          "status": "done",
          "permintaan": (value['permintaan']) - 1,
          "pendonor": FieldValue.arrayUnion([uid.value])
        });
      });
    } catch (e) {
      print(e.toString());
    }
    Get.offAllNamed(Routes.BLOOD_DONOR);
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
}
