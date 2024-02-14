import 'package:siimple/main.dart';
import 'package:siimple/pushNotificationSystem/push_notification_system.dart';
import 'package:siimple/tabScreens/favourite_sent_favourite_received_screen.dart';
import 'package:siimple/tabScreens/like_sent_like_received_screen.dart';
import 'package:siimple/tabScreens/swiping_screen.dart';
import 'package:siimple/tabScreens/user_details_screen.dart';
import 'package:siimple/tabScreens/view_sent_view_received_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List tabScreenList = [
    SwippingScreen(),
    ViewSentViewReceivedScreen(),
    FavouriteSentFavouriteReceivedScreen(),
    LikeSentLikeReceivedScreen(),
    UserDetailsScreen(
      userID: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.whenNotificationReceived(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        leading: IconButton(
          icon: Switch(
            value: isWhite,
            onChanged: (value) {
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black45,
          ),
          onPressed: () => "",
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber) {
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: isWhite ? Colors.white : Colors.black,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.purple,
        currentIndex: screenIndex,
        items: const [
          //Swipping Screen Icon Button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: ""),

          //ViewSentViewReceived Icon Button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                size: 30,
              ),
              label: ""),

          //FavouriteSentFavouriteReceived Icon Button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: ""),

          //LikeSentLikeReceived Icon Button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ""),

          //UserDetailsScreen Icon Button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: ""),
        ],
      ),
      body: tabScreenList[screenIndex],
    );
  }
}
