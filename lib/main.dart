import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:siimple/allProviders/chat_provider.dart';
import 'package:siimple/allProviders/home_provider.dart';
import 'package:siimple/allProviders/setting_provider.dart';
// import 'package:siimple/allScreens/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:siimple/authenticationScreen/login_screen.dart';
import 'package:siimple/controllers/authentication_controller.dart';
import 'package:siimple/homeScreen/home_screen.dart';
import 'allConstants/app_constants.dart';
import 'allProviders/auth_provider.dart';

bool isWhite = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCzzmw2sP99qegNLqPB6Rs3I66ks25_XyE",
    // paste your api key here
    appId: "1:833397462294:android:a02864b0adffc12402ec37",
    //paste your app id here
    messagingSenderId: "833397462294",
    //paste your messagingSenderId here
    projectId: "siimple-9cccd",
    storageBucket: "siimple-9cccd.appspot.com", //paste your project id here
  )).then((value) {
    Get.put(AuthenticationController());
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: firebase.FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) =>
              HomeProvider(firebaseFirestore: this.firebaseFirestore),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            firebaseFirestore: this.firebaseFirestore,
            prefs: this.prefs,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
      ],
      child: GetMaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
