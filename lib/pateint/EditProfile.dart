import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:tealth_project/pateint/pateintProfile.dart';
import 'package:tealth_project/widgets/progress.dart';

import '../widgets/bottombar.dart';
import 'homepage.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({required this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;
  bool _NameValid = true;
  bool _emailValid = true;
  bool _ageValid = true;
  bool _phoneNumberValid = true;
  final secondaryColor = const Color(0xff0095FF);

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    setState(() {
      isLoading = false;
    });
  }

  Column buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              " Name",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        TextField(
          controller: NameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 5)),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Update  Name",
            errorText: _NameValid ? null : " Enter Name",
          ),
        )
      ],
    );
  }

  Column buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 10),
            child: Text(
              " Email",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 5)),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Update  Email",
            errorText: _emailValid ? null : " Enter Email",
          ),
        )
      ],
    );
  }

  Column buildAgeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 10),
            child: Text(
              " Age",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        TextField(
            controller: ageController,
            // autofocus: true,
            decoration: InputDecoration(
              errorText: _ageValid ? null : " Enter Age",
              // fillColor: Colors.blue,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 5)),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Update Age",
            ))
      ],
    );
  }

  Column buildphoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: 10),
          child: Text(
            "phoneNumber",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        TextField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 5)),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Update phoneNumber",
            errorText: _phoneNumberValid ? null : "Enter corect phoneNumber",
          ),
        )
      ],
    );
  }

  updateProfileData() async {
    setState(() {
      NameController.text.trim().length < 3 || NameController.text.isEmpty
          ? _NameValid = false
          : _NameValid = true;
      phoneNumberController.text.trim().length > 100
          ? _phoneNumberValid = false
          : _phoneNumberValid = true;
      emailController.text.trim().length > 100
          ? _emailValid = false
          : _emailValid = true;
    });

    // if (_NameValid && _phoneNumberValid) {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      "firstName": NameController.text,
      "phoneNumber": phoneNumberController.text,
      "email": emailController.text,
      "age": ageController.text,
    });
    if (NameController.text == null &&
        phoneNumberController.text == null &&
        emailController.text == null &&
        ageController.text == null) {
      SnackBar snackbar = SnackBar(
        content: Text(
          "Enter data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      );
      _scaffoldKey.currentState!.showSnackBar(snackbar);
    } else {
      SnackBar snackbar = SnackBar(
        content: Text(
          "Profile updated!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      );
      _scaffoldKey.currentState!.showSnackBar(snackbar);
    }
    // }
  }

  // logout() async {
  //   await googleSignIn.signOut();
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Edit Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: circularProgress(),
            )
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            //  buildNameField(),
                            buildphoneNumberField(),
                            buildEmailField(),
                            //  buildAgeField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: updateProfileData,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('Update Data',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void logout() {}
}
