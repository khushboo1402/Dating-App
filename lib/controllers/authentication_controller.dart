import 'dart:io';

import 'package:siimple/authenticationScreen/login_screen.dart';
import 'package:siimple/homeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siimple/models/person.dart' as personModel;

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();

  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile;

  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  pickImageFileFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "You have successfully picked your profile image from gallery");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFromPhoneCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "You have successfully captured your profile image using camera.");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  Future<String> uploadImageTostorage(File imageFile) async {
    Reference referenceStorage = FirebaseStorage.instance
        .ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = referenceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;
    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

    return downloadUrlOfImage;
  }

  createNewUserAccount(
    //Personal info
    File imageProfile,
    String name,
    String email,
    String password,
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
    try {
      //1. Authenticate user and create user with email and password
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //2. Upload image to Firebase Storage
      String urlOfDownloadedImage = await uploadImageTostorage(imageProfile);

      //3. Save user information to Firestore Database
      personModel.Person personInstance = personModel.Person(

          //Personal info
          uid: FirebaseAuth.instance.currentUser!.uid,
          imageProfile: urlOfDownloadedImage,
          name: name,
          email: email,
          password: password,
          age: int.parse(age),
          gender: gender.toLowerCase(),
          phoneNo: phoneNo,
          city: city,
          country: country,
          profileHeading: profileHeading,
          lookingForInaPartner: lookingForInaPartner,
          publishedDateTime: DateTime.now().microsecondsSinceEpoch,

          // Appearance

          height: height,
          weight: weight,
          bodyType: bodyType,

          //Life Style
          drink: drink,
          smoke: smoke,
          maritalStatus: maritalStatus,
          haveChildren: haveChildren,
          noOfChildren: noOfChildren,
          profession: profession,
          employmentStatus: employmentStatus,
          income: income,
          livingSituation: livingSituation,
          willingToRelocate: willingToRelocate,
          relationshipYouAreLookingFor: relationshipYouAreLookingFor,

          //Background and Cultural Values
          nationality: nationality,
          education: education,
          languageSpoken: languageSpoken,
          religion: religion,
          ethnicity: ethnicity);

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());

      Get.snackbar(
          "Account Created", "Congratulations! Your account has been created");
      Get.to(HomeScreen());
    } catch (errorMsg) {
      Get.snackbar(
          "Account Creation Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailUser,
        password: passwordUser,
      );

      Get.snackbar("Logged in Successfully", "You're logged in successfully");

      Get.to(HomeScreen());
    } catch (errorMsg) {
      Get.snackbar("Login Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  checkIfUserIsLoggedIn(User? currentUser) {
    if (currentUser == null) {
      Get.to(LoginScreen());
    } else {
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}
