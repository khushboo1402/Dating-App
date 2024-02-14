import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:siimple/allConstants/constants.dart';
import 'package:siimple/allProviders/auth_provider.dart';
import 'package:siimple/allWidgets/loading_view.dart';
import 'package:siimple/authenticationScreen/registration_screen.dart';
import 'package:siimple/controllers/authentication_controller.dart';
import 'package:siimple/homeScreen/home_screen.dart';
import 'package:siimple/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  var controllerAuth = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    ///ChatApp
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }

    ///ChatApp

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "images/logo.png",
                width: 300,
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Login now to find your best Match",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor),
              ),
              //Space
              const SizedBox(
                height: 28,
              ),
              //email
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    36, //set as per the user screen size
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailTextEditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),
              //password
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    36, //set as per the user screen size
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              //login button
              Container(
                width: MediaQuery.of(context).size.width -
                    36, //set as per the user screen size
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: InkWell(
                  onTap: () async {
                    if (emailTextEditingController.text.trim().isNotEmpty &&
                        passwordTextEditingController.text.trim().isNotEmpty) {
                      setState(() {
                        showProgressBar = true;
                      });

                      await controllerAuth.loginUser(
                          emailTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim());

                      setState(() {
                        showProgressBar = false;
                      });
                    } else {
                      Get.snackbar("Email/Password is Missing",
                          "Please fill all fields");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Login",
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

              //Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(RegistrationScreen());
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),

              //space
              const SizedBox(
                height: 16,
              ),

              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    )
                  : Container(),

              //space
              const SizedBox(
                height: 16,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () async {
                    bool isSuccess = await authProvider.handleSignIn();
                    if (isSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  },
                  child: Image.asset("images/google_login.jpg"),
                ),
              ),
              Positioned(
                child: authProvider.status == Status.authenticating
                    ? LoadingView()
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
