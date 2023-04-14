import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

///Firebase ...
final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore kFireStore = FirebaseFirestore.instance;

/// firebase collection route..
CollectionReference chatCollection = kFireStore.collection('Chat');
CollectionReference followCollection = kFireStore.collection('Follow');
CollectionReference appleIdsCollection = kFireStore.collection('AppleId');



List<Map<String, dynamic>> kBottomBarLIst = [
  {'title': "Home", 'icon': Icons.home_outlined},
  {'title': "Explore", 'icon': Icons.search},
  {'title': "Appointment", 'icon': Icons.calendar_today_outlined},
  {'title': "Profile", 'icon': Icons.person_outline},
];

