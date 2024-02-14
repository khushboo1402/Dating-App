import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:siimple/global.dart';
import 'package:siimple/homeScreen/home_screen.dart';
import 'package:siimple/widgets/custom_text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0;

  //Personal Info
  //
  // TextEditingController emailTextEditingController = TextEditingController();
  // TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController =
      TextEditingController();
  TextEditingController lookingForInaPartnerEditingController =
      TextEditingController();

  //Appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //Life style
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController maritalStatusTextEditingController =
      TextEditingController();
  TextEditingController haveChildrenTextEditingController =
      TextEditingController();
  TextEditingController noOfChildrenTextEditingController =
      TextEditingController();
  TextEditingController professionTextEditingController =
      TextEditingController();
  TextEditingController employmentStatusTextEditingController =
      TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController =
      TextEditingController();
  TextEditingController willingToRelocateTextEditingController =
      TextEditingController();
  TextEditingController relationshipYouAreLookingForTextEditingController =
      TextEditingController();

  //Background - Cultural Values
  TextEditingController nationalityTextEditingController =
      TextEditingController();
  TextEditingController educationTextEditingController =
      TextEditingController();
  TextEditingController languageSpokenTextEditingController =
      TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController ethnicityTextEditingController =
      TextEditingController();

  //Personal Info
  String name = '';
  String age = '';
  String gender = '';
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

  chooseImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  uploadImages() async {
    int i = 1;
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      var refImages = FirebaseStorage.instance.ref().child(
          "images/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img).whenComplete(() async {
        await refImages.getDownloadURL().then((urlImage) {
          urlsList.add(urlImage);
          i++;
        });
      });
    }
  }

  retriveUserData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          //Personal Info
          name = snapshot.data()!["name"];
          nameTextEditingController.text = name;

          age = snapshot.data()!["age"].toString();
          ageTextEditingController.text = age;

          gender = snapshot.data()!["gender"].toString();
          genderTextEditingController.text = gender;

          phoneNo = snapshot.data()!["phoneNo"];
          phoneNoTextEditingController.text = phoneNo;

          city = snapshot.data()!["city"];
          cityTextEditingController.text = city;

          country = snapshot.data()!["country"];
          countryTextEditingController.text = country;

          profileHeading = snapshot.data()!["profileHeading"];
          profileHeadingTextEditingController.text = profileHeading;

          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];
          lookingForInaPartnerEditingController.text = lookingForInaPartner;

          // Appearance
          height = snapshot.data()!["height"];
          heightTextEditingController.text = height;

          weight = snapshot.data()!["weight"];
          weightTextEditingController.text = weight;

          bodyType = snapshot.data()!["bodyType"];
          bodyTypeTextEditingController.text = bodyType;

          //Life Style
          drink = snapshot.data()!["drink"];
          drinkTextEditingController.text = drink;

          smoke = snapshot.data()!["smoke"];
          smokeTextEditingController.text = smoke;

          maritalStatus = snapshot.data()!["maritalStatus"];
          maritalStatusTextEditingController.text = maritalStatus;

          haveChildren = snapshot.data()!["haveChildren"];
          haveChildrenTextEditingController.text = haveChildren;

          noOfChildren = snapshot.data()!["noOfChildren"];
          noOfChildrenTextEditingController.text = noOfChildren;

          profession = snapshot.data()!["profession"];
          professionTextEditingController.text = profession;

          employmentStatus = snapshot.data()!["employmentStatus"];
          employmentStatusTextEditingController.text = employmentStatus;

          income = snapshot.data()!["income"];
          incomeTextEditingController.text = income;

          livingSituation = snapshot.data()!["livingSituation"];
          livingSituationTextEditingController.text = livingSituation;

          willingToRelocate = snapshot.data()!["willingToRelocate"];
          willingToRelocateTextEditingController.text = willingToRelocate;

          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];
          relationshipYouAreLookingForTextEditingController.text =
              relationshipYouAreLookingFor;

          //Background and Cultural Values
          nationality = snapshot.data()!["nationality"];
          nationalityTextEditingController.text = nationality;

          education = snapshot.data()!["education"];
          educationTextEditingController.text = education;

          languageSpoken = snapshot.data()!["languageSpoken"];
          languageSpokenTextEditingController.text = languageSpoken;

          religion = snapshot.data()!["religion"];
          religionTextEditingController.text = religion;

          ethnicity = snapshot.data()!["ethnicity"];
          ethnicityTextEditingController.text = ethnicity;
        });
      }
    });
  }

  updateUserDataToFireStoreDatabase(
    //Personal info
    String name,
    String age,
    String gender,
    String phoneNo,
    String city,
    String country,
    String profileHeading,
    String lookingForInaPartner,

    // Appearance
    String height,
    String weight,
    String bodyType,

    //Life Style
    String drink,
    String smoke,
    String maritalStatus,
    String haveChildren,
    String noOfChildren,
    String profession,
    String employmentStatus,
    String income,
    String livingSituation,
    String willingToRelocate,
    String relationshipYouAreLookingFor,

    //Background and Cultural Values
    String nationality,
    String education,
    String languageSpoken,
    String religion,
    String ethnicity,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Uploading Images..."),
                ],
              )),
            ),
          );
        });
    await uploadImages();

    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      //Personal Data
      'name': name,
      'age': int.parse(age),
      'gender': gender.toLowerCase(),
      'phoneNo': phoneNo,
      'city': city,
      'country': country,
      'profileHeading': profileHeading,
      'lookingForInaPartner': lookingForInaPartner,

      // Appearance
      'height': height,
      'weight': weight,
      'bodyType': bodyType,

      //Life Style
      'drink': drink,
      'smoke': smoke,
      'maritalStatus': maritalStatus,
      'haveChildren': haveChildren,
      'noOfChildren': noOfChildren,
      'profession': profession,
      'employmentStatus': employmentStatus,
      'income': income,
      'livingSituation': livingSituation,
      'willingToRelocate': willingToRelocate,
      'relationshipYouAreLookingFor': relationshipYouAreLookingFor,

      //Background and Cultural Values
      'nationality': nationality,
      'education': education,
      'languageSpoken': languageSpoken,
      'religion': religion,
      'ethnicity': ethnicity,

      //images
      'urlImage1': urlsList[0].toString(),
      'urlImage2': urlsList[1].toString(),
      'urlImage3': urlsList[2].toString(),
      'urlImage4': urlsList[3].toString(),
      'urlImage5': urlsList[4].toString(),
    });

    Get.snackbar("Updated", "Your account has been updated successfully. ");

    Get.to(HomeScreen());

    setState(() {
      uploading = false;
      urlsList.clear();
      _image.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose 5 Images",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          next
              ? Container()
              : IconButton(
                  onPressed: () {
                    if (_image.length == 1) {
                      setState(() {
                        uploading = true;
                        next = true;
                      });
                    } else {
                      Get.snackbar("Images", "Please choose atleast 1 Image");
                    }
                  },
                  icon: const Icon(
                    Icons.navigate_next_outlined,
                    size: 36,
                  ))
        ],
      ),
      body: next
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),

                    //PERSONAL INFO

                    const Text(
                      "Personal Info",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //name
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: nameTextEditingController,
                        labelText: "Name",
                        iconData: Icons.person_outline,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //age
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: ageTextEditingController,
                        labelText: "Age",
                        iconData: Icons.numbers,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                    //gender
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: genderTextEditingController,
                        labelText: "Gender",
                        iconData: Icons.person_pin,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //phoneNo
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: phoneNoTextEditingController,
                        labelText: "Phone",
                        iconData: Icons.phone,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //city
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: cityTextEditingController,
                        labelText: "City",
                        iconData: Icons.location_city,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //country
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: countryTextEditingController,
                        labelText: "Country",
                        iconData: Icons.location_city,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //profileHeading
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: profileHeadingTextEditingController,
                        labelText: "Profile Heading",
                        iconData: Icons.text_fields,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //lookingForInaPartner
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController:
                            lookingForInaPartnerEditingController,
                        labelText: "What are you looking for in a partner?",
                        iconData: Icons.face,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //APPEARANCE
                    const Text(
                      "Appearance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //height
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: heightTextEditingController,
                        labelText: "Height",
                        iconData: Icons.insert_chart,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //weight
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: weightTextEditingController,
                        labelText: "Weight",
                        iconData: Icons.table_chart,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //bodyType
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: bodyTypeTextEditingController,
                        labelText: "Body Type",
                        iconData: Icons.type_specimen,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //LIFE STYLE
                    const Text(
                      "Life Style",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //drink
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: drinkTextEditingController,
                        labelText: "Drink",
                        iconData: Icons.local_drink_outlined,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //smoke
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: smokeTextEditingController,
                        labelText: "Smoke",
                        iconData: Icons.smoking_rooms,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Marital Status
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: maritalStatusTextEditingController,
                        labelText: "Marital Status",
                        iconData: CupertinoIcons.person_2,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Have Children
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: haveChildrenTextEditingController,
                        labelText: "Do you have children?",
                        iconData: CupertinoIcons.person_3_fill,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //No Of Children
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: noOfChildrenTextEditingController,
                        labelText: "Number of Children (if any)",
                        iconData: CupertinoIcons.person_3_fill,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Profession
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: professionTextEditingController,
                        labelText: "Profession",
                        iconData: Icons.business_center,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Employment Status
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController:
                            employmentStatusTextEditingController,
                        labelText: "Employment Status",
                        iconData:
                            CupertinoIcons.rectangle_stack_person_crop_fill,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Income
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: incomeTextEditingController,
                        labelText: "Income",
                        iconData: CupertinoIcons.money_dollar_circle,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Living Situation
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: livingSituationTextEditingController,
                        labelText: "Living Situation",
                        iconData: CupertinoIcons.person_2_square_stack,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Willing To Relocate
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController:
                            willingToRelocateTextEditingController,
                        labelText: "Are you willing To Relocate?",
                        iconData: CupertinoIcons.person_2,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //RelationshipYouAreLookingFor
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController:
                            relationshipYouAreLookingForTextEditingController,
                        labelText: "What relationship you are looking for?",
                        iconData: CupertinoIcons.person_2,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //BACKGROUND AND CULTURAL VALUES
                    const Text(
                      "Background and Cultural Values",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //nationality
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: nationalityTextEditingController,
                        labelText: "Nationality",
                        iconData: Icons.flag_circle_outlined,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //education
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: educationTextEditingController,
                        labelText: "Education",
                        iconData: Icons.history_edu,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Language Spoken
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: languageSpokenTextEditingController,
                        labelText: "Language Spoken",
                        iconData: CupertinoIcons.person_badge_plus_fill,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Religion
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: religionTextEditingController,
                        labelText: "Religion",
                        iconData: CupertinoIcons.checkmark_seal_fill,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    //Ethnicity
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 55,
                      child: CustomTextFieldWidget(
                        editingController: ethnicityTextEditingController,
                        labelText: "Ethnicity",
                        iconData: CupertinoIcons.eye,
                        isObscure: false,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    //Create Account Button
                    Container(
                      width: MediaQuery.of(context).size.width -
                          36, //set as per the user screen size
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: InkWell(
                        onTap: () async {
                          if (
                              //Personal info
                              nameTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  ageTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  genderTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  phoneNoTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  cityTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  countryTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  profileHeadingTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  lookingForInaPartnerEditingController.text
                                      .trim()
                                      .isNotEmpty &&

                                  // Appearance
                                  heightTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  weightTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  bodyTypeTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&

                                  //Life Style
                                  drinkTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  smokeTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  maritalStatusTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  haveChildrenTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  noOfChildrenTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  professionTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  employmentStatusTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  incomeTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  livingSituationTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  willingToRelocateTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  relationshipYouAreLookingForTextEditingController
                                      .text
                                      .trim()
                                      .isNotEmpty &&

                                  //Background and Cultural Values
                                  nationalityTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  educationTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  languageSpokenTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  religionTextEditingController.text
                                      .trim()
                                      .isNotEmpty &&
                                  ethnicityTextEditingController.text
                                      .trim()
                                      .isNotEmpty) {
                            _image.length > 0
                                ? await updateUserDataToFireStoreDatabase(
                                    //Personal info
                                    nameTextEditingController.text.trim(),
                                    ageTextEditingController.text.trim(),
                                    genderTextEditingController.text.trim(),
                                    phoneNoTextEditingController.text.trim(),
                                    cityTextEditingController.text.trim(),
                                    countryTextEditingController.text.trim(),
                                    profileHeadingTextEditingController.text
                                        .trim(),
                                    lookingForInaPartnerEditingController.text
                                        .trim(),

                                    // Appearance
                                    heightTextEditingController.text.trim(),
                                    weightTextEditingController.text.trim(),
                                    bodyTypeTextEditingController.text.trim(),

                                    //Life Style
                                    drinkTextEditingController.text.trim(),
                                    smokeTextEditingController.text.trim(),
                                    maritalStatusTextEditingController.text
                                        .trim(),
                                    haveChildrenTextEditingController.text
                                        .trim(),
                                    noOfChildrenTextEditingController.text
                                        .trim(),
                                    professionTextEditingController.text.trim(),
                                    employmentStatusTextEditingController.text
                                        .trim(),
                                    incomeTextEditingController.text.trim(),
                                    livingSituationTextEditingController.text
                                        .trim(),
                                    willingToRelocateTextEditingController.text
                                        .trim(),
                                    relationshipYouAreLookingForTextEditingController
                                        .text
                                        .trim(),

                                    //Background and Cultural Values
                                    nationalityTextEditingController.text
                                        .trim(),
                                    educationTextEditingController.text.trim(),
                                    languageSpokenTextEditingController.text
                                        .trim(),
                                    religionTextEditingController.text.trim(),
                                    ethnicityTextEditingController.text.trim())
                                : null;
                          } else {
                            Get.snackbar("A Field is Empty",
                                "Please fill out all fields in text fields");
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //space
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    itemCount: _image.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              color: Colors.white30,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    if (_image.length < 5) {
                                      !uploading ? chooseImage() : null;
                                    } else {
                                      setState(() {
                                        uploading == true;
                                      });
                                      Get.snackbar("5 Images already uploaded",
                                          "You cannot upload more images");
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image[index - 1]),
                                    fit: BoxFit.cover),
                              ),
                            );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
