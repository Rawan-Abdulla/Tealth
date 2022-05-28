import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tealth_project/doctor/PatientPro.dart';

import 'package:typicons_flutter/typicons_flutter.dart';

class SearchPa extends StatefulWidget {
  final String searchKey;
  const SearchPa({Key? key, required this.searchKey})
      : super(key: key);

  @override
  _SearchPaState createState() => _SearchPaState();
}

class _SearchPaState extends State<SearchPa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
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
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return snapshot.data?.size == 0
                ? Center(
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
                          Image(
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
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot patient = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Card(
                            color: Colors.blue[50],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 0),
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
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(patient['imageUrl']),
                                      //backgroundColor: Colors.blue,
                                      radius: 25,
                                    ),
                                    SizedBox(
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
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          patient['id'],
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Expanded(
                                    //   child: Container(
                                    //     alignment: Alignment.centerRight,
                                    //     child: Row(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.end,
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.end,
                                    //       children: [
                                    //         Icon(
                                    //           Typicons.star_full_outline,
                                    //           size: 20,
                                    //           color: Colors.indigo[400],
                                    //         ),
                                    //         SizedBox(
                                    //           width: 3,
                                    //         ),
                                    //         Text(
                                    //           doctor['id'].toString(),
                                    //           style: GoogleFonts.lato(
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 15,
                                    //             color: Colors.indigo,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
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
