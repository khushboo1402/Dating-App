import 'dart:developer';

import 'package:chat_app_codingcafe/models/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);

  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    usersProfileList.bindStream(FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot queryDataSnapshot) {
      List<Person> profileList = [];
      for (var eachProfile in queryDataSnapshot.docs) {
        profileList.add(Person.fromdataSnapshot((eachProfile)));
      }
      return profileList;
    }));
  }
}
