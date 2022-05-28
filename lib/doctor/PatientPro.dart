import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DrHomePage.dart';

class patientProfile extends StatefulWidget {
  final String patient;

  const patientProfile({Key? key, required this.patient}) : super(key: key);
  @override
  _patientProfileState createState() => _patientProfileState();
}

class _patientProfileState extends State<patientProfile> {
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
              .orderBy('id')
              .startAt([widget.patient]).endAt(
                  [widget.patient + '\uf8ff']).snapshots(),
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
                        Text(
                          document['id'],
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                  document['email'],
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
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              primary: Colors.indigo.withOpacity(0.9),
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreenDr()),
                              );
                            },
                            child: Text(
                              'View  Examinations',
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
}
