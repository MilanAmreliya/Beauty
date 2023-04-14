import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'comman_widget.dart';

class GetLocation {
  static double latitude = 0.0;
  static double longitude = 0.0;

  static Future<void> checkLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus != PermissionStatus.granted) {
      permissionStatus = await Permission.location.request();
      if (permissionStatus != PermissionStatus.granted) {
        permissionStatus = await Permission.location.request();
        if (permissionStatus != PermissionStatus.granted) {
          permissionStatus = await Permission.location.request();
        } else {
          await getLatLong();
          return;
        }
      } else {
        await getLatLong();
        return;
      }
    } else {
      await getLatLong();
      return;
    }

    // LocationPermission locationPermission = await Geolocator.checkPermission();
    // print('Status1 :$locationPermission');
    // if (locationPermission == LocationPermission.denied ||
    //     locationPermission == LocationPermission.deniedForever) {
    //   locationPermission = await Geolocator.requestPermission();
    //   print('Status2 :$locationPermission');
    //
    //   if (locationPermission == LocationPermission.denied ||
    //       locationPermission == LocationPermission.deniedForever) {
    //     locationPermission = await Geolocator.requestPermission();
    //     print('Status3 :$locationPermission');
    //
    //     await getLatLong();
    //   } else {
    //     await getLatLong();
    //   }
    // } else {
    //   await getLatLong();
    // }
  }

  static Future<void> getLatLong() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Lat Long :${position.latitude} ${position.longitude}');

      /*  latitude=21.2172638;
      longitude=72.8869927;*/
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (error) {
      print('Geolocator error $error');
    }
  }
}
