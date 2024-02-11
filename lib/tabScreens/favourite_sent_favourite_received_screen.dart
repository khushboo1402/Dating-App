import 'package:siimple/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouriteSentFavouriteReceivedScreen extends StatefulWidget {
  const FavouriteSentFavouriteReceivedScreen({super.key});

  @override
  State<FavouriteSentFavouriteReceivedScreen> createState() =>
      _FavouriteSentFavouriteReceivedScreenState();
}

class _FavouriteSentFavouriteReceivedScreenState
    extends State<FavouriteSentFavouriteReceivedScreen> {
  bool isFavouriteSentClicked = true;
  List<String> favouriteSentList = [];
  List<String> favouriteReceivedList = [];
  List favouriteList = [];

  getFavouriteListKeys() async {
    if (isFavouriteSentClicked) {
      var favouriteSentDocument = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID.toString())
          .collection("favouriteSent")
          .get();

      for (int i = 0; i < favouriteSentDocument.docs.length; i++) {
        favouriteSentList.add(favouriteSentDocument.docs[i].id);
      }
      getKeysDataFromUserCollection(favouriteSentList);
    } else {
      var favouriteReceivedDocument = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID.toString())
          .collection("favouriteReceived")
          .get();

      for (int i = 0; i < favouriteReceivedDocument.docs.length; i++) {
        favouriteReceivedList.add(favouriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUserCollection(favouriteReceivedList);
    }
  }

  getKeysDataFromUserCollection(List<String> keysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("Users").get();

    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          favouriteList.add(allUsersDocument.docs[i].data());
        }
      }
    }

    setState(() {
      favouriteList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    favouriteSentList.clear();
                    favouriteSentList = [];
                    favouriteReceivedList.clear();
                    favouriteReceivedList = [];
                    favouriteList.clear();
                    favouriteList = [];

                    setState(() {
                      isFavouriteSentClicked = true;
                    });
                    getFavouriteListKeys();
                  },
                  child: Text(
                    "My Favourites",
                    style: TextStyle(
                      color:
                          isFavouriteSentClicked ? Colors.white : Colors.grey,
                      fontWeight: isFavouriteSentClicked
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  )),
              const Text(
                "   |   ",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              TextButton(
                  onPressed: () {
                    favouriteSentList.clear();
                    favouriteSentList = [];
                    favouriteReceivedList.clear();
                    favouriteReceivedList = [];
                    favouriteList.clear();
                    favouriteList = [];

                    setState(() {
                      isFavouriteSentClicked = false;
                    });
                    getFavouriteListKeys();
                  },
                  child: Text(
                    "I'm their Favourite",
                    style: TextStyle(
                      color:
                          isFavouriteSentClicked ? Colors.grey : Colors.white,
                      fontWeight: isFavouriteSentClicked
                          ? FontWeight.normal
                          : FontWeight.bold,
                      fontSize: 14,
                    ),
                  ))
            ],
          ),
          centerTitle: true,
        ),
        body: favouriteList.isEmpty
            ? Center(
                child: Icon(
                  Icons.person_off_sharp,
                  color: Colors.white,
                  size: 60,
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(8),
                children: List.generate(favouriteList.length, (index) {
                  return GridTile(
                      child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      color: Colors.blue.shade200,
                      child: GestureDetector(
                        onTap: () {},
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                              favouriteList[index]["imageProfile"],
                            ),
                            fit: BoxFit.cover,
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),

                                  //name - age
                                  Text(
                                    favouriteList[index]["name"].toString() +
                                        " ○ " +
                                        favouriteList[index]["age"].toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  //Icon - city - country
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      Expanded(
                                        child: Text(
                                          favouriteList[index]["city"]
                                                  .toString() +
                                              " , " +
                                              favouriteList[index]["country"]
                                                  .toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
                }),
              ));
  }
}
