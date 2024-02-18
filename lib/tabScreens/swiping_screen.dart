import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:siimple/allScreens/chat_page.dart';
import 'package:siimple/controllers/profile_controller.dart';
import 'package:siimple/global.dart';
import 'package:siimple/tabScreens/user_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siimple/utilities/utilities.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:siimple/allScreens/chat_page.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {
  ProfileController profileController = Get.put(ProfileController());

  String senderName = "";
  // String senderId = "";
  // String imageProfile = "";
  startChattingInWhatsApp(String receiverPhoneNumber) async {
    var androidUrl =
        "whatsapp://send?phone=$receiverPhoneNumber&text=Hi, I found your profile on dating app.";
    var iosUrl =
        "https://wa.me/$receiverPhoneNumber?text=${Uri.parse('Hi, I found your profile on dating app.')}";

    try {
      if (Platform.isIOS) {
        await launchUrl((Uri.parse(iosUrl)));
      } else {
        await launchUrl((Uri.parse(androidUrl)));
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Whatsapp Not Found"),
              content: const Text("Whatsapp is not installed"),
              actions: [TextButton(onPressed: () {}, child: const Text("Ok"))],
            );
          });
    }
    ;
  }

  applyFilter() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                "Matching Filter",
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("I am looking for a:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text('Select gender'),
                      value: chosenGender,
                      underline: Container(),
                      items: ["Male", "Female", "Others", "None"].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chosenGender = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Who lives in:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text('Select country'),
                      value: chosenCountry,
                      underline: Container(),
                      items: [
                        "Spain",
                        "France",
                        "Germany",
                        "United Kingdom",
                        "Canada",
                        "United States",
                        "India",
                        "None"
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chosenCountry = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Who's age is equal to or above:"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text('Select age'),
                      value: chosenAge,
                      underline: Container(),
                      items: [
                        '18',
                        '20',
                        '25',
                        '30',
                        '35',
                        '40',
                        '45',
                        '50',
                        '55',
                        'None'
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chosenAge = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    profileController.getResults();
                  },
                  child: const Text("Done"),
                )
              ],
            );
          });
        });
  }

  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((dataSnapshot) {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
        // senderId = dataSnapshot.data()!["uid"].toString();
        // imageProfile = dataSnapshot.data()!["imageProfile"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getResults();
    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: profileController.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (profileController.allUsersProfileList.length > 0) {
              final eachProfileInfo =
                  profileController.allUsersProfileList[index];

              return DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                    eachProfileInfo.imageProfile.toString(),
                  ),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      //Filter Icon Button
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: IconButton(
                            onPressed: () {
                              applyFilter();
                            },
                            icon: const Icon(
                              Icons.filter_list,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      //user data
                      GestureDetector(
                        onTap: () {
                          profileController.viewSentAndViewReceived(
                            eachProfileInfo.uid.toString(),
                            senderName,
                          );

                          //send user to profile person user details screen
                          Get.to(UserDetailsScreen(
                            userID: eachProfileInfo.uid,
                          ));
                        },
                        child: Column(
                          children: [
                            //name
                            Text(
                              eachProfileInfo.name.toString(),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 24,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //age - city
                            Text(
                              eachProfileInfo.age.toString() +
                                  " ○ " +
                                  eachProfileInfo.city.toString(),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 14,
                                letterSpacing: 4,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            //work and religion
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      )),
                                  child: Text(
                                    eachProfileInfo.profileHeading.toString(),
                                    style: const TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                // ElevatedButton(
                                //   onPressed: () {},
                                //   style: ElevatedButton.styleFrom(
                                //       backgroundColor: Colors.white30,
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(16),
                                //       )),
                                //   child: Text(
                                //     eachProfileInfo.religion.toString(),
                                //     style: const TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 14,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),

                            //country and ethnicity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      )),
                                  child: Text(
                                    eachProfileInfo.country.toString(),
                                    style: const TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      )),
                                  child: Text(
                                    eachProfileInfo.profession.toString(),
                                    style: const TextStyle(
                                      color: Colors.pink,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      //image buttons : favourite - chat - like
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //favourite button
                          GestureDetector(
                            onTap: () {
                              profileController
                                  .favouriteSentAndFavouriteReceived(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );
                            },
                            child: Image.asset(
                              "images/star.png",
                              width: 60,
                            ),
                          ),

                          //chat button
                          GestureDetector(
                            // onTap: () {
                            //   startChattingInWhatsApp(
                            //       eachProfileInfo.phoneNo.toString());
                            //
                            //
                            // },
                            onTap: () {
                              if (Utilities.isKeyboardShowing()) {
                                Utilities.closeKeyboard(context);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    peerId: eachProfileInfo.uid.toString(),
                                    peerAvatar:
                                        eachProfileInfo.imageProfile.toString(),
                                    peerNickname:
                                        eachProfileInfo.name.toString(),
                                  ),
                                ),
                              );
                            },
                            // onTap: () {
                            //   Future.delayed(Duration.zero, () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => ChatPage(
                            //           peerId: eachProfileInfo.uid.toString(),
                            //           peerAvatar: eachProfileInfo.imageProfile
                            //               .toString(),
                            //           peerNickname:
                            //               eachProfileInfo.name.toString(),
                            //         ),
                            //       ),
                            //     );
                            //   });
                            // },
                            child: Image.asset("images/message.png",
                                width: 60, height: 60),
                          ),

                          //like button
                          GestureDetector(
                            onTap: () {
                              profileController.likeSentAndLikeReceived(
                                eachProfileInfo.uid.toString(),
                                senderName,
                              );
                            },
                            child: Image.asset(
                              "images/heart.png",
                              width: 60,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}
