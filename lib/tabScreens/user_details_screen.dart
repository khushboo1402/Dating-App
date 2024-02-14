import 'dart:developer';

import 'package:siimple/accountSettingsScreen/account_settings_screen.dart';
import 'package:siimple/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:siimple/main.dart';

class UserDetailsScreen extends StatefulWidget {
  String? userID;

  UserDetailsScreen({
    super.key,
    this.userID,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  //Personal Info
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profileHeading = '';
  String lookingForInaPartner = '';

  // Appearance
  String height = '';
  String weight = '';
  String bodyType = '';

  //Life Style
  String drink = '';
  String smoke = '';
  String maritalStatus = '';
  String haveChildren = '';
  String noOfChildren = '';
  String profession = '';
  String employmentStatus = '';
  String income = '';
  String livingSituation = '';
  String willingToRelocate = '';
  String relationshipYouAreLookingFor = '';

  //Background and Cultural Values
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';
  String ethnicity = '';

  //slider images
  String urlImage1 =
      "https://firebasestorage.googleapis.com/v0/b/siimple-dating-app.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=31b75251-8319-4802-8ab6-5b4d3d2025ba";
  String urlImage2 =
      "https://firebasestorage.googleapis.com/v0/b/siimple-dating-app.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=31b75251-8319-4802-8ab6-5b4d3d2025ba";
  String urlImage3 =
      "https://firebasestorage.googleapis.com/v0/b/siimple-dating-app.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=31b75251-8319-4802-8ab6-5b4d3d2025ba";
  String urlImage4 =
      "https://firebasestorage.googleapis.com/v0/b/siimple-dating-app.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=31b75251-8319-4802-8ab6-5b4d3d2025ba";
  String urlImage5 =
      "https://firebasestorage.googleapis.com/v0/b/siimple-dating-app.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=31b75251-8319-4802-8ab6-5b4d3d2025ba";

  retrieveUserInfo() async {
    // debugger();
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["urlImage1"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }

        setState(() {
          //Personal Info
          name = snapshot.data()!["name"];
          age = snapshot.data()!["age"].toString();
          phoneNo = snapshot.data()!["phoneNo"];
          city = snapshot.data()!["city"];
          country = snapshot.data()!["country"];
          profileHeading = snapshot.data()!["profileHeading"];
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];

          // Appearance
          height = snapshot.data()!["height"];
          weight = snapshot.data()!["weight"];
          bodyType = snapshot.data()!["bodyType"];

          //Life Style
          drink = snapshot.data()!["drink"];
          smoke = snapshot.data()!["smoke"];
          maritalStatus = snapshot.data()!["maritalStatus"];
          haveChildren = snapshot.data()!["haveChildren"];
          noOfChildren = snapshot.data()!["noOfChildren"];
          profession = snapshot.data()!["profession"];
          employmentStatus = snapshot.data()!["employmentStatus"];
          income = snapshot.data()!["income"];
          livingSituation = snapshot.data()!["livingSituation"];
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];

          //Background and Cultural Values
          nationality = snapshot.data()!["nationality"];
          education = snapshot.data()!["education"];
          languageSpoken = snapshot.data()!["languageSpoken"];
          religion = snapshot.data()!["religion"];
          ethnicity = snapshot.data()!["ethnicity"];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.pink,
          ),
        ),
        centerTitle: true,
        // automaticallyImplyLeading:
        //     widget.userID == currentuserID ? false : true,

        leading: widget.userID != currentuserID
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                ),
              )
            : Container(),
        actions: [
          widget.userID == currentuserID
              ? Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(AccountSettingsScreen());
                        },
                        icon: const Icon(
                          Icons.settings,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                        )),
                  ],
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //image slider
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Carousel(
                    indicatorBarColor: Colors.black.withOpacity(0.3),
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Colors.black,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.network(
                        urlImage1,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage2,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage3,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage4,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        urlImage5,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),

              // const SizedBox(
              //   height: 10.0,
              // ),

              //Personal Info Title
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Personal Info",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.pink,
                thickness: 2,
              ),

              //Personal Info Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //Name
                    TableRow(children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Age
                    TableRow(children: [
                      const Text(
                        "Age: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        age,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Phone Number
                    TableRow(children: [
                      const Text(
                        "Phone Number: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        phoneNo,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //City
                    TableRow(children: [
                      const Text(
                        "City: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        city,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //country
                    TableRow(children: [
                      const Text(
                        "Country: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        country,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //profile heading
                    TableRow(children: [
                      const Text(
                        "Profile Heading: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        profileHeading,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //looking for in a partner
                    TableRow(children: [
                      const Text(
                        "Seeking: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        lookingForInaPartner,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),

              //Appearance Title
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Appearance",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              //Appearance Table Data
              Container(
                color: isWhite ? Colors.white : Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //Height
                    TableRow(children: [
                      const Text(
                        "Height: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        height,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Weight
                    TableRow(children: [
                      const Text(
                        "Weight: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        weight,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Body Type
                    TableRow(children: [
                      const Text(
                        "Body Type: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        bodyType,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),

              //Lifestyle Title
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Lifestyle",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              //Lifestyle Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //Height
                    TableRow(children: [
                      const Text(
                        "Drink: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        drink,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Smoke
                    TableRow(children: [
                      const Text(
                        "Smoke: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        smoke,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Marital Status
                    TableRow(children: [
                      const Text(
                        "Marital Status: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        maritalStatus,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Profession
                    TableRow(children: [
                      const Text(
                        "Profession: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        profession,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),
                  ],
                ),
              ),

              //Background and Cultural Title
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Background and Cultural Values",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              //Background and Cultural Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20.0),
                child: Table(
                  children: [
                    //Nationality
                    TableRow(children: [
                      const Text(
                        "Nationality: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        nationality,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Education
                    TableRow(children: [
                      const Text(
                        "Education: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        education,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),

                    //Language Spoken
                    TableRow(children: [
                      const Text(
                        "Language Spoken: ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        languageSpoken,
                        style: const TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                        ),
                      ),
                    ]),

                    //extra row
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
