import 'dart:convert';
import 'dart:developer';

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
    // TODO: implement onInit
    super.onInit();

    if (chosenGender == null || chosenCountry == null || chosenAge == null) {
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
    } else {
      usersProfileList.bindStream(FirebaseFirestore.instance
          .collection("Users")
          .where("gender", isEqualTo: chosenGender.toString().toLowerCase())
          .where("country", isEqualTo: chosenCountry.toString())
          .where("age", isEqualTo: int.parse(chosenAge.toString()))
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

  favouriteSentAndFavouriteReceived(String toUserID, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(toUserID)
        .collection("favouriteReceived")
        .doc(currentuserID)
        .get();

    //remove the favourite from database if already marked favourite
    if (document.exists) {
      //Remove currentuserID from the favourite Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("favouriteReceived")
          .doc(currentuserID)
          .delete();

      //Remove profile person [toUserID] from the favourite Sent List of the currentuserID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID)
          .collection("favouriteSent")
          .doc(toUserID)
          .delete();
    } else // if not exists then mark as favourite in database
    {
      //Add currentuserID to the favourite Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("favouriteReceived")
          .doc(currentuserID)
          .set({});

      //Add profile person [toUserID] to the favourite Sent List of the currentuserID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID)
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
        .doc(currentuserID)
        .get();

    //remove the like from database if already marked favourite
    if (document.exists) {
      //Remove currentuserID from the like Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("likeReceived")
          .doc(currentuserID)
          .delete();

      //Remove profile person [toUserID] from the like Sent List of the currentuserID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID)
          .collection("likeSent")
          .doc(toUserID)
          .delete();
    } else // if not exists then mark as like in database
    {
      //Add currentuserID to the like Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("likeReceived")
          .doc(currentuserID)
          .set({});

      //Add profile person [toUserID] to the like Sent List of the currentuserID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID)
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
        .doc(currentuserID)
        .get();

    if (document.exists) {
      print("already in view list");
    } else // if not exists then add seen feature in database
    {
      //Add currentuserID to the view Received List of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(toUserID)
          .collection("viewReceived")
          .doc(currentuserID)
          .set({});

      //Add profile person [toUserID] to the View Sent List of the currentuserID
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID)
          .collection("viewSent")
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "View", senderName);
    }
    update();
  }

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
      "senderID": currentuserID,
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
