import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tealth_project/Lab/LabHome.dart';
import 'package:tealth_project/lab/EditProfileLab.dart';
import 'package:tealth_project/model/user_model.dart';

import '../main.dart';
import '../widgets/bottombar.dart';

class LabPage extends StatefulWidget {
  const LabPage() : super();
  @override
  _LabPageState createState() => _LabPageState();
}

class _LabPageState extends State<LabPage> {
  final secondaryColor = const Color(0xff0095FF);

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
          child:
              // ListView.builder(
              //   itemBuilder: (context, index) {
              Container(
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage("${loggedInUser.imageUrl}"),
              //backgroundColor: Colors.lightBlue[100],
              radius: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${loggedInUser.firstName} ",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.email),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      "${loggedInUser.email} ",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.place_outlined),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      "${loggedInUser.location} ",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
            SizedBox(
              height: 0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.access_time_rounded),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Working Hours',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(left: 60),
              child: Row(
                children: [
                  Text(
                    'Today: ',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${loggedInUser.StartWorkTime} " +
                        " - " +
                        "${loggedInUser.EndWorkTime} ",
                    style: GoogleFonts.lato(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   height: 50,
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       elevation: 2,
            //       primary: Colors.indigo.withOpacity(0.9),
            //       onPrimary: Colors.black,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(32.0),
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BookingScreen(
            //             patient: document['name'],
            //           ),
            //         ),
            //       );
            //     },
            //     child: Text(
            //       'Book an Appointment',
            //       style: GoogleFonts.lato(
            //         color: Colors.white,
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      )
          // },
          // ),
          ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
