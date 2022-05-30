// // ignore_for_file: use_key_in_widget_constructors

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<AiForm> createForm(String title) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return AiForm.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create Form.');
//   }
// }

// class AiForm {
//   final String age;
//   final String gender;
//   final String height;
//   final String weight;
//   final String ap_hi;
//   final String ap_lo;
//   final String holesterol;
//   final String gluc;
//   final String smoke;
//   final String alco;
//   final String active;

//   const AiForm(this.age, this.gender, this.height, this.weight, this.ap_hi, this.ap_lo, this.holesterol, this.gluc, this.smoke, this.alco, this.active, {required this.id, required this.title});

//   factory AiForm.fromJson(Map<String, dynamic> json) {
//     return AiForm(
//       age: json['age'],
//       gender: json['gender'],
//           height: json['height'],
//       weight: json['weight'],
//           ap_hi: json['ap_hi'],
//       ap_lo: json['ap_lo'],
//           holesterol: json['holesterol'],
//       gluc: json['gluc'],
//           smoke: json['smoke'],
//       alco: json['alco'],
//           active: json['active'], id: null,

//     );
//   }
// }

// class Ai extends StatefulWidget {
//   const Ai({Key? key}) : super(key: key);

//   @override
//   _AiState createState() {
//     return _AiState();
//   }
// }

// class _AiState extends State<Ai> {
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _heightController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _ap_hiController = TextEditingController();
//   final TextEditingController _ap_loController = TextEditingController();
//   final TextEditingController _cholesterolController = TextEditingController();
//   final TextEditingController _glucController = TextEditingController();
//   final TextEditingController _smokeController = TextEditingController();
//   final TextEditingController _alcoController = TextEditingController();
//   final TextEditingController _activeController = TextEditingController();
//   Future<AiForm>? _futureAlbum;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create Data Example'),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
//         ),
//       ),
//     );
//   }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         TextField(
//           controller: _ageController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _genderController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _heightController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _weightController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _ap_hiController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _ap_loController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _cholesterolController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _glucController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _smokeController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _alcoController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         TextField(
//           controller: _activeController,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureAlbum = createForm(_ageController.text);
//             });
//           },
//           child: const Text('Create Data'),
//         ),
//       ],
//     );
//   }

//   FutureBuilder<AiForm> buildFutureBuilder() {
//     return FutureBuilder<AiForm>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.age);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tealth_project/main.dart';
import 'package:tealth_project/model/FormAi_model.dart';
import 'package:tealth_project/pateint/PatinetBar.dart';
import 'package:tealth_project/pateint/homepage.dart';

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

Future<AiModel?> createAi(
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
  final Uri apiUrl = Uri.parse("");

  final response = await http.post(apiUrl, body: {
    "age": age,
    "gender": gender,
    "height": height,
    "weight": weight,
    "ap_hi": ap_hi,
    "ap_lo": ap_lo,
    "cholesterol": cholesterol,
    "gluc": gluc,
    "smoke": smoke,
    "alco": alco,
    "active": active,
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class _AiFormState extends State<AiForm> {
  late AiModel form = AiModel(
      age: "",
      gender: "",
      height: "",
      weight: "",
      ap_hi: "",
      ap_lo: "",
      cholesterol: "",
      gluc: "",
      smoke: "",
      alco: "",
      active: "");

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
      body: Container(
        // padding: EdgeInsets.all(32),
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
                  // hintText: "hintText",
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
            form == null
                ? Container()
                : Text(
                    "The user ${form.age}, ${form.gender},${form.height},${form.weight},${form.ap_hi},${form.ap_lo},${form.gluc},${form.smoke} is created successfully at time ${form.active}"),
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

          final AiModel? AiForm = await createAi(age, gender, height, weight,
              ap_hi, ap_lo, cholesterol, gluc, smoke, alco, active);

          setState(() {
            form = AiForm!;
          });
        },
        tooltip: 'Increment',
        label: const Text('Predication'),
        icon: const Icon(Icons.wb_incandescent_outlined),
        backgroundColor: Colors.blue,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
