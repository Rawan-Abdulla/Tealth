import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tealth_project/doctor/PatientPro.dart';

class SearchPa extends StatefulWidget {
  final String searchKey;
  const SearchPa({Key? key, required this.searchKey}) : super(key: key);

  @override
  _SearchPaState createState() => _SearchPaState();
}

class _SearchPaState extends State<SearchPa> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Patients'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('id')
            .startAt([widget.searchKey]).endAt([widget.searchKey]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          image: AssetImage('assets/error.png'),
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
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(patient['imageUrl']),
                                    radius: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
      //drawer: NavDrawerDr(),
    );
  }
}
