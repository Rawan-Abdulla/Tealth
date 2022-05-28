import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:typicons_flutter/typicons_flutter.dart';

import 'patientProfile.dart';

class SearchListPatient extends StatefulWidget {
  final String searchKey;
  const SearchListPatient({Key? key, required this.searchKey})
      : super(key: key);

  @override
  _SearchListPatientState createState() => _SearchListPatientState();
}

class _SearchListPatientState extends State<SearchListPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Patients"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('id')
              .startAt([widget.searchKey]).endAt(
                  [widget.searchKey]).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data?.size == 0
                ? Center(
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Patient found!',
                            style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Image(
                            image: AssetImage('assets/error-404.jpg'),
                            height: 250,
                            width: 250,
                          ),
                        ],
                      ),
                    ),
                  )
                : Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot patient = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Card(
                            color: Colors.blue[200],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 9,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => patientProfile(
                                        patient: patient['id'],
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(patient['imageUrl']),
                                      radius: 25,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          patient['firstName'],
                                          style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Typicons.star_full_outline,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              patient['id'].toString(),
                                              style: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
