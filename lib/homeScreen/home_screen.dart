import 'package:chat_app_codingcafe/tabScreens/favourite_sent_favourite_received_screen.dart';
import 'package:chat_app_codingcafe/tabScreens/like_sent_like_received_screen.dart';
import 'package:chat_app_codingcafe/tabScreens/swiping_screen.dart';
import 'package:chat_app_codingcafe/tabScreens/user_details_screen.dart';
import 'package:chat_app_codingcafe/tabScreens/view_sent_view_received_screen.dart';
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
    UserDetailsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber) {
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
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
