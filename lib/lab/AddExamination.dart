import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tealth_project/Lab/LabHome.dart';
import 'package:tealth_project/widgets/bar.dart';

class AddingExamination extends StatefulWidget {
  final String patient;

  const AddingExamination({Key? key, required this.patient}) : super(key: key);
  @override
  _AddingExaminationState createState() => _AddingExaminationState();
}

class _AddingExaminationState extends State<AddingExamination> {
  late DocumentSnapshot document;

  final secondaryColor = const Color(0xff0095FF);
  // ignore: unnecessary_new
  final valueEditingController = new TextEditingController();
  // ignore: unnecessary_new
  final testEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Examinations"),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy('id')
              .startAt([widget.patient]).endAt([widget.patient]).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
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
                  document = snapshot.data!.docs[index];
                  return Container(

                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 85),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[

                          const Text(
                            "Select The Test ",
                            style: TextStyle(fontSize: 25, height: 2.5),
                          ),
                          Container(
                            width: 300,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                // ignore: prefer_const_literals_to_create_immutables
                                items: [
                                  "micro albumine urea",
                                  "cyclosporin level",
                                  "HBalc",
                                  "c3-SERUM",
                                  "c4-SERUM",
                                  "lgA-SERUM",
                                  "lgM-SERUM",
                                  "lgG-SERUM",
                                  "lgE-SERUM",
                                  "ALPHA1-AT-SERUM",
                                  "TSH-SERUM",
                                  "PROLACTIN-SERUM",
                                  "LH-SERUM",
                                  "T3 FREE-SERUM",
                                  "T4 TOTAL-SERUM",
                                  "T4-SERUM",
                                  "FSH-SERUM",
                                  "PROGESTERONE-SERUM",
                                  "ubella(German Measles) lgG",
                                  "ESTRADIOL-17B,E2-SERUM",
                                  "TESTOSTERONE-FREE",
                                  "ROWTH HORMONE-SERUM",
                                  "ACETONE",
                                  "ALBUMIN-SERUM",
                                  "LK.PHOSPHATASE-SERUM",
                                  "BUN-SERUM",
                                  "CALCIUM-SERUM",
                                  "CHLORIDE-SERUM",
                                  "CPK-SERUM",
                                  "CREATININE-SERUM",
                                  "BILIRUBIN-SERUM",
                                  "GAMA.G.T-SERUM",
                                  "GLOBULIN-SERUM",
                                  "FBS-SERUM",
                                  "BILIRUBIN T-SERUM",
                                  "URIC ACID-urin",
                                  "HBs Ag",
                                  "RUBELLA igG",
                                  "HIV",
                                ],
                                onChanged: (val) {
                                  testEditingController.text = val!;
                                },
                                selectedItem: "Select"),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Value of  the test ",
                            style: TextStyle(fontSize: 25, height: 2.5),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 70),
                            child: TextFormField(
                                autofocus: false,
                                controller: valueEditingController,
                                onSaved: (value) {
                                  valueEditingController.text = value!;
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.fromLTRB(20, 25, 20, 15),
                                  border: OutlineInputBorder(

                                  ),
                                )),
                          ),
                          const SizedBox(height: 30),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff0095FF),
                            child: MaterialButton(
                                padding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                minWidth: MediaQuery.of(context).size.width / 2,
                                onPressed: () {
                                  //    print(document['uid']);
                                  User? user = FirebaseAuth.instance.currentUser;

                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(document['uid'])
                                      .collection('examinations')
                                      .doc()
                                      .set({
                                    'name': testEditingController.text,
                                    'value': valueEditingController.text,
                                    // 'lab': user?.uid.n,
                                    'created AT': DateTime.now()
                                  });

                                  showAlertDialog(context);
                                },
                                child: const Text(
                                  "Add an Examination ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        'NO',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bar()),
        );
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'YES',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddingExamination(patient: document['id'])),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Adding examiantion is Done!"),
      content: const Text("Are you sure you want to add another examiantion?"),
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
}
