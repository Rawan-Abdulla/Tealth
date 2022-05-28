import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:tealth_project/pateint/pateintProfile.dart';
import 'package:tealth_project/widgets/progress.dart';

import '../widgets/bottombar.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({required this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController startWorkTimeController = TextEditingController();
  TextEditingController EndWorkTimeController = TextEditingController();
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;
  bool _NameValid = true;
  bool _emailValid = true;
  bool _startWorkTimeValid = true;
  bool _EndWorkTimeValid = true;
  bool _locationValid = true;
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

  Column buildStartWorkTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 10),
            child: Text(
              "Start Work Time",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        TextField(
            controller: startWorkTimeController,
            // autofocus: true,
            decoration: InputDecoration(
              errorText: _startWorkTimeValid ? null : " Start Work Time",
              // fillColor: Colors.blue,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 5)),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Update Start Work Time",
            ))
      ],
    );
  }

  Column buildEndWorkTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 10),
            child: Text(
              "End Work Time",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
        TextField(
            controller: EndWorkTimeController,
            // autofocus: true,
            decoration: InputDecoration(
              errorText: _EndWorkTimeValid ? null : " End Work Time",
              // fillColor: Colors.blue,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 5)),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Update End Work Time",
            ))
      ],
    );
  }

  Column buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0, bottom: 10),
          child: Text(
            "Location",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: [
              "Abu Dis",
              "Bani Na'im",
              "Bani Suheila",
              "Beit Jala",
              "Beit Sahour",
              "Beit Ummar",
              "Beitunia",
              "Bethlehem ",
              "Jenin",
              "Tulkarm",
              "Nablus",
              "Tubas",
              "Sa'ir",
              "Ramallah",
              "Qalqilya",
              "Jericho",
              "Hebron",
              "Halhul",
              "al-Bireh"
            ],
            // label: "Location",
            hint: "Your Location ?",
            onChanged: (val) {
              locationController.text = val!;
            },
            selectedItem: "Select"),
      ],
    );
  }

  updateProfileData() async {
    setState(() {
      // NameController.text.trim().length < 3 || NameController.text.isEmpty
      //     ? _NameValid = false
      //     : _NameValid = true;
      // locationController.text.trim().length > 100
      //     ? _locationValid = false
      //     : _locationValid = true;
      // emailController.text.trim().length > 100
      //     ? _emailValid = false
      //     : _emailValid = true;
    });

    // if (_NameValid && _phoneNumberValid) {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      "firstName": NameController.text,
      "location": locationController.text,
      "email": emailController.text,
      "StartWorkTime": startWorkTimeController.text,
      "EndtWorkTime": EndWorkTimeController.text,
    });
    // if (NameController.text == null &&
    //     locationController.text == null &&
    //     emailController.text == null &&
    //     startWorkTimeController.text == null) {
    //   SnackBar snackbar = SnackBar(
    //     content: Text(
    //       "Enter data",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     backgroundColor: Colors.blue,
    //   );
    //   _scaffoldKey.currentState!.showSnackBar(snackbar);
    // } else {
    SnackBar snackbar = SnackBar(
      content: Text(
        "Profile updated!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
    _scaffoldKey.currentState!.showSnackBar(snackbar);
    // }
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
          "Edit Profile",
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
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 16.0,
                        bottom: 10.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          buildNameField(),
                          buildLocationField(),
                          buildEmailField(),
                          buildStartWorkTimeField(),
                          buildEndWorkTimeField()
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
                        child: const Text('Update Profile',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  void logout() {}
}
