import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tealth_project/pateint/booking.dart';
import 'package:url_launcher/url_launcher.dart';

import 'booking.dart';

class DoctorProfile extends StatefulWidget {
  final String doctor;

  const DoctorProfile({Key? key, required this.doctor}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  static final CollectionReference requestsCollection =
      FirebaseFirestore.instance.collection('requests');
  User? current_user = FirebaseAuth.instance.currentUser;
  bool isAccepted = false;
  _launchCaller(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('firstName')
              .startAt([widget.doctor]).endAt(
                  [widget.doctor + '\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          child: IconButton(
                            icon: Icon(
                              Icons.chevron_left_sharp,
                              color: Colors.indigo,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(document['imageUrl']),
                          //backgroundColor: Colors.lightBlue[100],
                          radius: 80,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          document['firstName'],
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          document['specialistDoctor'],
                          style: GoogleFonts.lato(
                              //fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black54),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     for (var i = 0; i < document['rating']; i++)
                        //       Icon(
                        //         Icons.star_rounded,
                        //         color: Colors.indigoAccent,
                        //         size: 30,
                        //       ),
                        //     if (5 - document['rating'] > 0)
                        //       for (var i = 0; i < 5 - document['rating']; i++)
                        //         Icon(
                        //           Icons.star_rounded,
                        //           color: Colors.black12,
                        //           size: 30,
                        //         ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 14,
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
                                  document['location'],
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
                              Icon(Icons.transgender),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Text(
                                  document['gender'],
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
                              TextButton(
                                onPressed: () => _launchCaller(
                                    "tel:" + document['phoneNumber']),
                                child: Text(
                                  document['phoneNumber'].toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.black),
                                ),
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
                                document['StartWorkTime'] +
                                    " - " +
                                    document['EndWorkTime'],
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              onPrimary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingScreen(
                                    doctor: document['firstName'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Book an Appointment',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.blue,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              showAlertDialog(context,
                                  doctorID: document['uid'],
                                  patientID: current_user!.uid);
                              sendRequestToPatient(
                                  doctorID: document['uid'],
                                  patientID: current_user!.uid,
                                  isAccepted: isAccepted);
                            },
                            child: Text(
                              'Allow acsess to your examinations',
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,
      {required String doctorID, required String patientID}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("yes"),
      onPressed: () {
        String requestID;
        isAccepted = true;
        requestID = '$doctorID-$patientID';
        print(requestID);
        respondToRequest(isAccepted: isAccepted, requestID: requestID);
      },
    );
    Widget continueButton = TextButton(
      child: Text("No"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Acess Examinations"),
      content: Text("Would you want to allow acess to your examinations?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> sendRequestToPatient(
      {required String doctorID,
      required String patientID,
      required bool isAccepted}) async {
    await requestsCollection.doc('$doctorID-$patientID').set({
      'patientID': patientID,
      'doctorID': doctorID,
      'time': DateTime.now(),
      'accepted': isAccepted,
    });
  }

  static Future<void> respondToRequest({
    required String requestID,
    required bool isAccepted,
  }) async {
    await requestsCollection.doc(requestID).update(
      {
        'accepted': isAccepted,
      },
    );
  }
}
