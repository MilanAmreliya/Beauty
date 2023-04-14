import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comman/get_location.dart';

Future<void> locationAlertDialog()async{
  Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black87, width: 2),
              borderRadius: BorderRadius.circular(20.0)),
          title: Text('Permission',textAlign: TextAlign.center,),
          content: Text(
            'This app use Location. Please ON Location Permission',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: ()async{
                await GetLocation.checkLocationPermission();
                print('lat long :${GetLocation.latitude}');
                if(GetLocation.latitude !=0.0){
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
      barrierDismissible: false);
}