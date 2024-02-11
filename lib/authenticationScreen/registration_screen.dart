import 'dart:io';

import 'package:siimple/controllers/authentication_controller.dart';
import 'package:siimple/widgets/custom_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //Personal Info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
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

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "to get Started Now.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //Choose image circle avatar
              authenticationController.imageFile == null
                  ? const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("images/profile_avatar.jpg"),
                      backgroundColor: Colors.black,
                    )
                  : Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: FileImage(File(
                                authenticationController.imageFile!.path,
                              )))),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await authenticationController.pickImageFileFromGallery();

                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () async {
                      await authenticationController
                          .captureImageFromPhoneCamera();

                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
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
                  editingController: lookingForInaPartnerEditingController,
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
                  editingController: employmentStatusTextEditingController,
                  labelText: "Employment Status",
                  iconData: CupertinoIcons.rectangle_stack_person_crop_fill,
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
                  editingController: willingToRelocateTextEditingController,
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
                    if (authenticationController.imageFile != null) {
                      if (
                          //Personal info
                          nameTextEditingController.text.trim().isNotEmpty &&
                              emailTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              passwordTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              ageTextEditingController.text.trim().isNotEmpty &&
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
                        setState(() {
                          showProgressBar = true;
                        });
                        await authenticationController.createNewUserAccount(
                            //Personal info
                            authenticationController.profileImage!,
                            nameTextEditingController.text.trim(),
                            emailTextEditingController.text.trim(),
                            passwordTextEditingController.text.trim(),
                            ageTextEditingController.text.trim(),
                            genderTextEditingController.text.trim(),
                            phoneNoTextEditingController.text.trim(),
                            cityTextEditingController.text.trim(),
                            countryTextEditingController.text.trim(),
                            profileHeadingTextEditingController.text.trim(),
                            lookingForInaPartnerEditingController.text.trim(),

                            // Appearance
                            heightTextEditingController.text.trim(),
                            weightTextEditingController.text.trim(),
                            bodyTypeTextEditingController.text.trim(),

                            //Life Style
                            drinkTextEditingController.text.trim(),
                            smokeTextEditingController.text.trim(),
                            maritalStatusTextEditingController.text.trim(),
                            haveChildrenTextEditingController.text.trim(),
                            noOfChildrenTextEditingController.text.trim(),
                            professionTextEditingController.text.trim(),
                            employmentStatusTextEditingController.text.trim(),
                            incomeTextEditingController.text.trim(),
                            livingSituationTextEditingController.text.trim(),
                            willingToRelocateTextEditingController.text.trim(),
                            relationshipYouAreLookingForTextEditingController
                                .text
                                .trim(),

                            //Background and Cultural Values
                            nationalityTextEditingController.text.trim(),
                            educationTextEditingController.text.trim(),
                            languageSpokenTextEditingController.text.trim(),
                            religionTextEditingController.text.trim(),
                            ethnicityTextEditingController.text.trim());

                        setState(() {
                          showProgressBar = false;
                          authenticationController.imageFile == null;
                        });
                      } else {
                        Get.snackbar("A Field is Empty",
                            "Please fill out all fields in text fields");
                      }
                    } else {
                      Get.snackbar("Image File Missing",
                          "Please pick image from gallery or capture with camera");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Create Account",
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

              //Already have an account, login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      "Login Here",
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
            ],
          ),
        ),
      ),
    );
  }
}
