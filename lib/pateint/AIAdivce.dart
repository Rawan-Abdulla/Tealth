import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tealth_project/model/FormAi_model.dart';
import 'package:tealth_project/model/user_model.dart';
import 'package:tealth_project/pateint/PatinetBar.dart';

class AiForm extends StatefulWidget {
  const AiForm({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AiFormState createState() => _AiFormState();
}

Future<dynamic> createAi(
    String age,
    String gender,
    String height,
    String weight,
    String ap_hi,
    String ap_lo,
    String cholesterol,
    String gluc,
    String smoke,
    String alco,
    String active) async {
  final list = {
    'age': age,
    'gender': gender,
    'height': height,
    'weight': weight,
    'ap_hi': ap_hi,
    'ap_lo': ap_lo,
    'cholesterol': cholesterol,
    'gluc': gluc,
    'smoke': smoke,
    'alco': alco,
    'active': active
  };

  Uri url = Uri.http('172.20.10.2:8844', '', list);
  http.Response res = await http.get(url);
  print(res.body);
  if (res.statusCode == 201) {
    //  final String responseString = res.body;
    dynamic result = jsonDecode(res.body);
    return {"predict": result["predict"], "Error": result["Error"]};
  } else {
    return null;
  }
}

class _AiFormState extends State<AiForm> {
  Map<String, dynamic> output = {};
  User? user = FirebaseAuth.instance.currentUser;
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  set loggedInUser(UserModel loggedInUser) {}
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

  late AiModel form = AiModel(
      age: "36575",
      gender: "2",
      height: "198",
      weight: "66.5",
      ap_hi: "110",
      ap_lo: "60",
      cholesterol: "2",
      gluc: "1",
      smoke: "0",
      alco: "0",
      active: "1");

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ap_hiController = TextEditingController();
  final TextEditingController _ap_loController = TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _glucController = TextEditingController();
  final TextEditingController _smokeController = TextEditingController();
  final TextEditingController _alcoController = TextEditingController();
  final TextEditingController _activeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PateintBar()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          children: <Widget>[
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Pleas Enter your age in days ",
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Pleas Enter 1 if you Female, 2 if you Male ",
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Pleas Enter your height in cm ",
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Pleas Enter your whight in kg ",
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _ap_hiController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Pleas Enter your whight in kg ",
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _ap_loController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _cholesterolController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _glucController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _smokeController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Pleas Enter 0 if you are somking, 1 if not ",
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _alcoController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _activeController,
              decoration: InputDecoration(
                  // fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 5)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final String age = _ageController.text;
          final String gender = _genderController.text;
          final String height = _heightController.text;
          final String weight = _weightController.text;
          final String ap_hi = _ap_hiController.text;
          final String ap_lo = _ap_loController.text;
          final String cholesterol = _cholesterolController.text;
          final String gluc = _glucController.text;
          final String smoke = _smokeController.text;
          final String alco = _alcoController.text;
          final String active = _activeController.text;

          // ignore: non_constant_identifier_names

          setState(() async {
            output = await createAi(age, gender, height, weight, ap_hi, ap_lo,
                cholesterol, gluc, smoke, alco, active);
            if (output == {"predict": "0", "Error": 0}) {
              _showMyDialogNo;
            } else if (output == {"predict": "1", "Error": 0}) {
              _showMyDialogYes();
            } else {
              _showMyDialogError();
            }
          });
        },
        tooltip: 'Increment',
        label: const Text('Predication'),
        icon: const Icon(Icons.wb_incandescent_outlined),
        backgroundColor: Colors.blue,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  static Future<List<QueryDocumentSnapshot>?> getPatientExaminations(
      patientID) async {
    return (await usersCollection
            .doc(patientID)
            .collection('examinations')
            .get())
        .docs;
  }

  // Future<void> getdate() async {
  //   Uri url = Uri.https(
  //     ' http://192.168.0.110:8844//',);
  //   http.Response res = await http.get(url);
  //   print(res.body);
  // }
  Future<void> _showMyDialogYes() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Our advice'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'There is a problem with entering data.. Make sure you follow the instructions correctly.'),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Go to home Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PateintBar()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogNo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Our advice'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your health is fine.'),
                Text('Keep going!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Go to Home page to Find correct doctor!'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PateintBar()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Opps!!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You have some problems, try again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Again!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
