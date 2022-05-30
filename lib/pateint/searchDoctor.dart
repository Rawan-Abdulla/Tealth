import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/pateint/doctorProfile.dart';
import 'package:tealth_project/pateint/pateintProfile.dart';
import 'package:tealth_project/pateint/homepage.dart';
import '../widgets/bottombar.dart';
import 'doctorProfile.dart';
import 'homepage.dart';

class searchDoctor extends StatefulWidget {
  @override
  State<searchDoctor> createState() => _searchDoctorState();
}

class _searchDoctorState extends State<searchDoctor> {
  final secondaryColor = const Color(0xff0095FF);

  final TextEditingController controller = TextEditingController();

  // bool isVisible = false;
  late QuerySnapshot<Object?> data;

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  Icon customIcon = const Icon(Icons.search);

  String nameQuery = '';
  String specialityQuery = '';
  String genderQuery = '';
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
            user['specialistDoctor'] != null &&
            (user['specialistDoctor'] as String).contains(
              specialityQuery,
            ) &&
            (user['gender'] as String)
                .toLowerCase()
                .contains(genderQuery.toLowerCase()) &&
            user['location'] != null &&
            (user['location'] as String).contains(
              locationQuery,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
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
                    searchDropdownFieldspeciality(
                      field: 'speciality',
                      hintText: 'Speciality',
                      options: [
                        "allergist",
                        "anesthesiologist",
                        "cardiologist",
                        "chiropractor",
                        "dentist",
                        "dermatologist",
                        "fertility specialist",
                        "gynecologist",
                        "massage therapist",
                        "midwife",
                        "naturopath",
                        "neurologist",
                        "obstetrician",
                        "occupational therapist",
                        "oncologist",
                        "ophthalmologist",
                        "pediatrician",
                        "physical therapist",
                        "podiatrist",
                        "psychiatrist",
                        "radiologist",
                        "Reproductive endocrinologists and infertility",
                        "Surgery",
                        "Internal Medicine Physician",
                        "Urology",
                        "Psychiatrist",
                        "Otolaryngologist",
                        "Endocrinologist",
                        "Nephrologist",
                        "Infectious Disease Physician",
                        "Pulmonologist",
                        "Gastroenterologist"
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
                        searchDropdownField(
                          field: 'gender',
                          hintText: 'Gender',
                          options: ['Male', 'Female'],
                        ),
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
                        "All Doctors",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 10),
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
                          if (docs[index]['role'] == 'Doctor') {
                            // if (data.docs[index]['firstName'] == controller) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DoctorProfile(
                                        doctor: docs[index]['firstName']),
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
                                subtitle:
                                    Text("${docs[index]['specialistDoctor']}"),
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
                specialityQuery = val;
                break;
            }
          });
        },
      ),
    );
  }

  Widget searchDropdownField(
      {required String hintText,
      required String field,
      required List<String> options}) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        // autofocus: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.blue))),
        hint: const Text('Gender'),
        value: genderQuery != "" ? genderQuery : null,
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
              case 'gender':
                genderQuery = val ?? "";
                break;
            }
          });
        },
      ),
    );
  }

  void logout(BuildContext context) {}

  searchDropdownFieldspeciality(
      {required String field,
      required String hintText,
      required List<String> options}) {
    return DropdownButtonFormField<String>(
      //autofocus: true,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: Colors.blue))),
      hint: const Text('Speciality'),
      value: specialityQuery != "" ? specialityQuery : null,
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
            case 'speciality':
              specialityQuery = val ?? "";
              break;
          }
        });
      },
    );
  }

  searchDropdownFieldLocation(
      {String? field,
      required String hintText,
      required List<String> options}) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        // autofocus: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.blue))),
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
