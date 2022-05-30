import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/pateint/DoctorProfile.dart';
import 'package:tealth_project/pateint/LabPage.dart';
import 'package:tealth_project/pateint/pateintProfile.dart';
import 'package:tealth_project/pateint/homepage.dart';
import '../widgets/bottombar.dart';
import 'homepage.dart';

class searchLab extends StatefulWidget {
  @override
  State<searchLab> createState() => _searchLabState();
}

class _searchLabState extends State<searchLab> {
  final secondaryColor = const Color(0xff0095FF);

  final TextEditingController controller = TextEditingController();

  // bool isVisible = false;
  late QuerySnapshot<Object?> data;

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  Icon customIcon = const Icon(Icons.search);

  String nameQuery = '';
  String locationQuery = '';
  // Map<String, String> queries = {
  //   'name': "",
  //   speciality: "",

  // }

  List<Map<String, dynamic>> getFilteredList(List<QueryDocumentSnapshot> docs) {
    List<Map<String, dynamic>> data = docs
        .map(
          (QueryDocumentSnapshot doc) => doc.data() as Map<String, dynamic>,
        )
        .toList();

    return data
        .where((Map<String, dynamic> user) =>
            (user['firstName'] as String).toLowerCase().contains(
                  nameQuery.toLowerCase(),
                ) &&
            user['location'] != null &&
            (user['location'] as String).contains(
              locationQuery,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title: Text('Find Lab'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        searchTextField(field: 'name', hintText: 'Name'),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        searchDropdownFieldLocation(
                          field: 'location',
                          hintText: 'Location',
                          options: [
                            "Abu Dis",
                            "Bani Na'im",
                            "Bani Suheila",
                            "Beit Jala",
                            "Beit Sahour",
                            "Beit Ummar",
                            "Beitunia",
                            "Bethlehem ",
                            "Jenin",
                            "Tulkarm",
                            "Nablus",
                            "Tubas",
                            "Sa'ir",
                            "Ramallah",
                            "Qalqilya",
                            "Jericho",
                            "Hebron",
                            "Halhul",
                            "al-Bireh"
                          ],
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All Labs",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: users,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text("somthing wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("loading");
                      }
                      data = snapshot.requireData;
                      var docs = getFilteredList(data.docs);
                      return ListView.builder(
                        // itemCount: data.size,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          if (docs[index]['role'] == 'Lab') {
                            // if (data.docs[index]['firstName'] == controller) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LabPage(Lab: docs[index]['firstName']),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${docs[index]['imageUrl']}"),
                                  //backgroundColor: Colors.blue,
                                  radius: 25,
                                ),
                                title: Text("${docs[index]['firstName']}"),
                                subtitle: Text("${docs[index]['location']}"),
                              ),
                            );
                          }

                          return Container();

                          // return Text(
                          //     "my name is ${data.docs[index]['firstName']} mmmm");
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget searchTextField({required String hintText, required String field}) {
    return Expanded(
      child: TextField(
        // autofocus: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 5)),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            // border: InputBorder.,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            )),
        onChanged: (val) {
          setState(() {
            switch (field) {
              case 'name':
                nameQuery = val;
                break;
              case 'location':
                locationQuery = val;
                break;
            }
          });
        },
      ),
    );
  }

  searchDropdownFieldLocation(
      {String? field,
      required String hintText,
      required List<String> options}) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.blue))),
        // autofocus: true,

        hint: const Text('Location'),
        value: locationQuery != "" ? locationQuery : null,
        items: options
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ),
            )
            .toList(),

        onChanged: (val) {
          setState(() {
            switch (field) {
              case 'location':
                locationQuery = val ?? "";
                break;
            }
          });
        },
      ),
    );
  }
}
