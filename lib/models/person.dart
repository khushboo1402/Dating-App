import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  //Personal info
  String? uid;
  String? imageProfile;
  String? name;
  String? email;
  String? password;
  int? age;
  String? gender;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForInaPartner;
  int? publishedDateTime;

  // Appearance
  String? height;
  String? weight;
  String? bodyType;

  //Life Style
  String? drink;
  String? smoke;
  String? maritalStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouAreLookingFor;

  //Background and Cultural Values
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;
  String? ethnicity;

  Person({
    //Personal info
    this.uid,
    this.imageProfile,
    this.name,
    this.email,
    this.password,
    this.age,
    this.gender,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeading,
    this.lookingForInaPartner,
    this.publishedDateTime,

    // Appearance
    this.height,
    this.weight,
    this.bodyType,

    //Life Style
    this.drink,
    this.smoke,
    this.maritalStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouAreLookingFor,

    //Background and Cultural Values
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
    this.ethnicity,
  });

  static Person fromdataSnapshot(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Person(
      //Personal info
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      imageProfile: dataSnapshot["imageProfile"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      age: dataSnapshot["age"],
      gender: dataSnapshot["gender"],
      phoneNo: dataSnapshot["phoneNo"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeading: dataSnapshot["profileHeading"],
      lookingForInaPartner: dataSnapshot["lookingForInaPartner"],
      publishedDateTime: dataSnapshot["publishedDateTime"],

      // Appearance
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],

      //Life Style
      drink: dataSnapshot["drink"],
      smoke: dataSnapshot["smoke"],
      maritalStatus: dataSnapshot["maritalStatus"],
      haveChildren: dataSnapshot["haveChildren"],
      noOfChildren: dataSnapshot["noOfChildren"],
      profession: dataSnapshot["profession"],
      employmentStatus: dataSnapshot["employmentStatus"],
      income: dataSnapshot["income"],
      livingSituation: dataSnapshot["livingSituation"],
      willingToRelocate: dataSnapshot["willingToRelocate"],
      relationshipYouAreLookingFor:
          dataSnapshot["relationshipYouAreLookingFor"],

      //Background and Cultural Values
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],
      ethnicity: dataSnapshot["ethnicity"],
    );
  }

  Map<String, dynamic> toJson() => {
        //Personal info
        "uid": uid,
        "imageProfile": imageProfile,
        "name": name,
        "email": email,
        "password": password,
        "age": age,
        "gender": gender,
        "phoneNo": phoneNo,
        "city": city,
        "country": country,
        "profileHeading": profileHeading,
        "lookingForInaPartner": lookingForInaPartner,
        "publishedDateTime": publishedDateTime,

        // Appearance
        "height": height,
        "weight": weight,
        "bodyType": bodyType,

        //Life Style
        "drink": drink,
        "smoke": smoke,
        "maritalStatus": maritalStatus,
        "haveChildren": haveChildren,
        "noOfChildren": noOfChildren,
        "profession": profession,
        "employmentStatus": employmentStatus,
        "income": income,
        "livingSituation": livingSituation,
        "willingToRelocate": willingToRelocate,
        "relationshipYouAreLookingFor": relationshipYouAreLookingFor,

        //Background and Cultural Values
        "nationality": nationality,
        "education": education,
        "languageSpoken": languageSpoken,
        "religion": religion,
        "ethnicity": ethnicity,
      };
}
