import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siimple/global.dart';
import 'package:siimple/models/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  getResults() {
    onInit();
  }

  @override
  void onInit() {
    super.onInit();
    // usersProfileLi/st.value = [];
    Stream<List<Person>>? userStream;
    checkFilterNull();

    if (chosenGender == null && chosenCountry == null && chosenAge == null) {
      retrieveAllUsers(userStream);
    } else {
      retrieveFilterUsers(userStream);
      // usersProfileList.bindStream(userStream!);
    }
  }

  void checkFilterNull() {
    if (chosenGender == 'None') chosenGender = null;
    if (chosenCountry == 'None') chosenCountry = null;
    if (chosenAge == 'None') chosenAge = null;
  }

  void retrieveAllIfNoDataFound(
      Stream<List<Person>>? userStream, Rx<List<Person>> usersProfileList) {
    retrieveAllUsers(userStream);
    displayMessage();
  }

  void displayMessage() {
    Get.snackbar(
      "Not found!!",
      "",
      titleText: const Text(
        "Looks like all the good fish have been caught (Try again with a different search)",
        style: TextStyle(color: Colors.blue), // Your desired color
      ),
    );
  }

  retrieveFilterUsers(Stream<List<Person>>? userStream) {
    userStream = FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot queryDataSnapshot) {
      // return queryDataSnapshot.docs
      final filteredList = queryDataSnapshot.docs
          .map((eachProfile) => Person.fromdataSnapshot(eachProfile))
          .where((person) {
        // Ensure null checks and type conversions:
        final genderMatch = chosenGender != null &&
            person.gender?.toLowerCase() == chosenGender?.toLowerCase();
        final countryMatch =
            chosenCountry != null && person.country == chosenCountry;
        final ageMatch = chosenAge != null &&
            int.tryParse(chosenAge!) != null &&
            person.age! <= int.parse(chosenAge!);
        print("====================================");
        print("Record : NAME - " + person.name!.toLowerCase());
        print("Record : Gender - " + person.gender!.toLowerCase());
        print("Record : Country - " + person.country!);
        print("Record : Age - " + person.age!.toString());

        print("Match : genderMatch - " + genderMatch.toString());
        print("Match : countryMatch - " + countryMatch.toString());
        print("Match : ageMatch - " + ageMatch.toString());
        print("====================================");

        // Combine filters dynamically:
        return filterRecordsDynamically(
            ageMatch, countryMatch, genderMatch); // Include all if no filters
      }).toList();
      if (filteredList.isEmpty) {
        retrieveAllIfNoDataFound(userStream, usersProfileList);
      }
      return filteredList; // Return the filtered list
    });

    usersProfileList.bindStream(userStream!);
    // return userStream;
  }

  bool filterRecordsDynamically(
      bool ageMatch, bool countryMatch, bool genderMatch) {
    return (chosenAge != null && chosenCountry != null && chosenGender != null)
        ? ageMatch && countryMatch && genderMatch
        : (chosenAge != null && chosenCountry != null)
            ? ageMatch && countryMatch
            : (chosenCountry != null && chosenGender != null)
                ? countryMatch && genderMatch
                : (chosenAge != null && chosenGender != null)
                    ? ageMatch && genderMatch
                    : (chosenAge != null)
                        ? ageMatch
                        : (chosenCountry != null)
                            ? countryMatch
                            : (chosenGender != null)
                                ? genderMatch
                                : true;
  }

  retrieveAllUsers(Stream<List<Person>>? userStream) {
    userStream = FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot queryDataSnapshot) {
      return queryDataSnapshot.docs
          .map((eachProfile) => Person.fromdataSnapshot(eachProfile))
          .toList();
    });
    usersProfileList.bindStream(userStream!);
  }

  favouriteSentAndFavouriteReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(toUserID)
        .collection("favouriteReceived")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    //remove the favourite from database if already marked favourite
    if (document.exists) {
      //Remove FirebaseAuth.instance.currentUser!.uid from the favourite Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("favouriteReceived")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();

      //Remove profile person [toUserID] from the favourite Sent List of the FirebaseAuth.instance.currentUser!.uid
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favouriteSent")
          .doc(toUserID)
          .delete();
    } else // if not exists then mark as favourite in database
    {
      //Add FirebaseAuth.instance.currentUser!.uid to the favourite Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("favouriteReceived")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});

      //Add profile person [toUserID] to the favourite Sent List of the FirebaseAuth.instance.currentUser!.uid
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favouriteSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Favourite", senderName);
    }
    update();
  }

  likeSentAndLikeReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(toUserID)
        .collection("likeReceived")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    //remove the like from database if already marked favourite
    if (document.exists) {
      //Remove FirebaseAuth.instance.currentUser!.uid from the like Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("likeReceived")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();

      //Remove profile person [toUserID] from the like Sent List of the FirebaseAuth.instance.currentUser!.uid
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("likeSent")
          .doc(toUserID)
          .delete();
    } else // if not exists then mark as like in database
    {
      //Add FirebaseAuth.instance.currentUser!.uid to the like Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("likeReceived")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});

      //Add profile person [toUserID] to the like Sent List of the FirebaseAuth.instance.currentUser!.uid
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("likeSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Like", senderName);
    }
    update();
  }

  viewSentAndViewReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(toUserID)
        .collection("viewReceived")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (document.exists) {
      print("already in view list");
    } else // if not exists then add seen feature in database
    {
      //Add FirebaseAuth.instance.currentUser!.uid to the view Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("viewReceived")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});

      //Add profile person [toUserID] to the View Sent List of the FirebaseAuth.instance.currentUser!.uid
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("viewSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "View", senderName);
    }
    update();
  }

  // chatUser(String toUserID, String senderName) async {
  //   var document = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //
  //   if (document.exists) {
  //     print("already in view list");
  //   } else // if not exists then add seen feature in database
  //   {
  //     //Add FirebaseAuth.instance.currentUser!.uid to the view Received List of that profile person [toUserID]
  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(toUserID)
  //         .collection("viewReceived")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set({});
  //
  //     //Add profile person [toUserID] to the View Sent List of the FirebaseAuth.instance.currentUser!.uid
  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("viewSent")
  //         .doc(toUserID)
  //         .set({});
  //
  //     //send notification
  //     sendNotificationToUser(toUserID, "View", senderName);
  //   }
  //   update();
  // }

  sendNotificationToUser(receiverID, featureType, senderName) async {
    String userDeviceToken = "";
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["userDeviceToken"] != null) {
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });

    notificationFormat(
      userDeviceToken,
      receiverID,
      featureType,
      senderName,
    );
  }

  notificationFormat(
    userDeviceToken,
    receiverID,
    featureType,
    senderName,
  ) {
    Map<String, String> headerNotification = {
      "Content-Type": "application/json",
      "Authorization": fcmServerToken,
    };

    Map bodyNotification = {
      "body":
          "You have received a new $featureType from $senderName. Click to see..",
      "title": "New $featureType",
    };
    Map dataMap = {
      "click-action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userID": receiverID,
      "senderID": FirebaseAuth.instance.currentUser!.uid,
    };

    Map notificationOfficialFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": userDeviceToken,
    };
    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(notificationOfficialFormat),
    );
  }
}
