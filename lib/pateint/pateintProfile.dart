import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../model/user_model.dart';
import '../widgets/bottombar.dart';
import '../widgets/profile_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'EditProfile.dart';
import 'getExamination.dart';
import 'homepage.dart';

class ProfileScreenPateint extends StatefulWidget {
  const ProfileScreenPateint({Key? key}) : super(key: key);

  @override
  _ProfileScreenPateintState createState() => _ProfileScreenPateintState();
}

var uid;
var url = 'https://cdn-icons-png.flaticon.com/512/194/194915.png';

class _ProfileScreenPateintState extends State<ProfileScreenPateint> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final secondaryColor = const Color(0xff0095FF);

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      url = value.get('imageUrl');
      if (url == '' || url == Null || url == null)
        url = 'https://cdn-icons-png.flaticon.com/512/194/194915.png';
      setState(() {});
    });
    uid = user?.uid;
    final storageRef = FirebaseStorage.instance.ref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text("${loggedInUser.firstName} "),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(
                            currentUserId: user!.uid,
                          )),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            ProfileWidget(
              imagePath: url,
              onClicked: () async {},
            ),
            const SizedBox(height: 20),
            buildName(),
            // const SizedBox(height: 20),
            const SizedBox(height: 20),
            buildAbout(),
          ],
        ));
  }

  Widget buildName() => Column(
        children: [
          Text(
            "${loggedInUser.firstName} ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildAbout() => Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 12,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.email),
                SizedBox(
                  width: 11,
                ),
                Text(
                  "${loggedInUser.email} ",
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.phone),
                SizedBox(
                  width: 11,
                ),
                Text(
                  "${loggedInUser.phoneNumber} ",
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.transgender),
                SizedBox(
                  width: 11,
                ),
                Text(
                  "${loggedInUser.gender} ",
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                ),
                // SizedBox(
                //   height: 7,
                // ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 12,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.calendar_month),
                SizedBox(
                  width: 11,
                ),
                Text(
                  "${loggedInUser.age} ",
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: secondaryColor,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => getExamination(),
                  ),
                );
              },
              child: Text(
                'View Your Examinations',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
