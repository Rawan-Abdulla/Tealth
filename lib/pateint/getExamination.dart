import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/pateint/pateintProfile.dart';
import '../main.dart';
import '../widgets/bottombar.dart';
import 'homepage.dart';

class getExamination extends StatefulWidget {
  const getExamination({Key? key}) : super(key: key);

  @override
  _getExaminationState createState() => _getExaminationState();
}

class _getExaminationState extends State<getExamination> {
  final secondaryColor = const Color(0xff0095FF);
  String nameQuery = '';
  String DateQuery = '';

  User? user = FirebaseAuth.instance.currentUser;
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  List<Map<String, dynamic>> getFilteredList(List<QueryDocumentSnapshot> docs) {
    List<Map<String, dynamic>> data = docs
        .map(
          (QueryDocumentSnapshot doc) => doc.data() as Map<String, dynamic>,
        )
        .toList();

    return data
        .where((Map<String, dynamic> user) =>
            (user['name'] as String).toLowerCase().contains(
                  nameQuery.toLowerCase(),
                ) &&
            (user['created AT'] as String).toLowerCase().contains(
                  nameQuery.toLowerCase(),
                ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text('Examinations'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Container(
                  height: 500,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: FutureBuilder<List<QueryDocumentSnapshot>?>(
                      future: getPatientExaminations(user?.uid),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (_, index) {
                              return Card(
                                elevation: 2,
                                child: InkWell(
                                  onTap: () {},
                                  child: ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              snapshot.data![index]['name'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54,
                                              )),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, right: 10, left: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Value Of Test: " +
                                                        snapshot.data![index]
                                                            ['value'],
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black54,
                                                    )),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                    "Time: " +
                                                        snapshot.data![index]
                                                                ['created AT']
                                                            .toDate()
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black54,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }))),
        ));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  static Future<List<QueryDocumentSnapshot>?> getPatientExaminations(
      patientID) async {
    return (await usersCollection
            .doc(patientID)
            .collection('examinations')
            .get())
        .docs;
  }

  Widget searchTextField({required String hintText, required String field}) {
    return Expanded(
      child: TextField(
        enabled: false,
        // autofocus: true,
        decoration: InputDecoration(
            // fillColor: Colors.blue,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 5)),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey)),
        onChanged: (val) {
          setState(() {
            switch (field) {
              case 'name':
                nameQuery = val;
                break;
              case 'speciality':
                DateQuery = val;
                break;
            }
          });
        },
      ),
    );
  }
}
