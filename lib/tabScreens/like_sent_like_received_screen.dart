import 'package:siimple/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siimple/main.dart';

class LikeSentLikeReceivedScreen extends StatefulWidget {
  const LikeSentLikeReceivedScreen({super.key});

  @override
  State<LikeSentLikeReceivedScreen> createState() =>
      _LikeSentLikeReceivedScreenState();
}

class _LikeSentLikeReceivedScreenState
    extends State<LikeSentLikeReceivedScreen> {
  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likesList = [];

  getLikedListKeys() async {
    if (isLikeSentClicked) {
      var likeSentDocument = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID.toString())
          .collection("likeSent")
          .get();

      for (int i = 0; i < likeSentDocument.docs.length; i++) {
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      getKeysDataFromUserCollection(likeSentList);
    } else {
      var likeReceivedDocument = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentuserID.toString())
          .collection("likeReceived")
          .get();

      for (int i = 0; i < likeReceivedDocument.docs.length; i++) {
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }
      getKeysDataFromUserCollection(likeReceivedList);
    }
  }

  getKeysDataFromUserCollection(List<String> keysList) async {
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("Users").get();

    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUsersDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          likesList.add(allUsersDocument.docs[i].data());
        }
      }
    }

    setState(() {
      likesList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  likeSentList.clear();
                  likeSentList = [];
                  likeReceivedList.clear();
                  likeReceivedList = [];
                  likesList.clear();
                  likesList = [];

                  setState(() {
                    isLikeSentClicked = true;
                  });
                  getLikedListKeys();
                },
                child: Text(
                  "My Likes",
                  style: TextStyle(
                    color: isLikeSentClicked ? Colors.pink : Colors.purple,
                    fontWeight:
                        isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                )),
            const Text(
              "   |   ",
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
            TextButton(
                onPressed: () {
                  likeSentList.clear();
                  likeSentList = [];
                  likeReceivedList.clear();
                  likeReceivedList = [];
                  likesList.clear();
                  likesList = [];

                  setState(() {
                    isLikeSentClicked = false;
                  });
                  getLikedListKeys();
                },
                child: Text(
                  "Who liked me?",
                  style: TextStyle(
                    color: isLikeSentClicked ? Colors.purple : Colors.pink,
                    fontWeight:
                        isLikeSentClicked ? FontWeight.normal : FontWeight.bold,
                    fontSize: 14,
                  ),
                ))
          ],
        ),
        centerTitle: true,
      ),
      body: likesList.isEmpty
          ? Center(
              child: Icon(
                Icons.person_off_sharp,
                color: Colors.pink,
                size: 60,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              children: List.generate(likesList.length, (index) {
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
                            likesList[index]["imageProfile"],
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
                                  likesList[index]["name"].toString() +
                                      " ○ " +
                                      likesList[index]["age"].toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.pink,
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
                                        likesList[index]["city"].toString() +
                                            " , " +
                                            likesList[index]["country"]
                                                .toString(),
                                        maxLines: 2,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.pink,
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
            ),
      backgroundColor: isWhite ? Colors.white : Colors.black,
    );
  }
}
