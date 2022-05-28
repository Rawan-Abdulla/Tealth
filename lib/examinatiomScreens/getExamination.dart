// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tealth_project/employeeDrawer.dart';
// import 'package:tealth_project/model/examination_catogry.dart';

// class getExamination extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return getExaminationState();
//   }
// }

// class getExaminationState extends State<getExamination> {
//   var employess = List<ExaminationCatogry>;
//   //.generate(200, (index) => null);

//   Future<List<ExaminationCatogry>> getEmployees() async {
//     var data = await http
//         .get(Uri.parse('http://10.0.2.2:8080/examination/api/v1//all'));
//     var jsonData = json.decode(data.body);

//     List<ExaminationCatogry> employee = [];
//     for (var e in jsonData) {
//       ExaminationCatogry employees = new ExaminationCatogry();
//       employees.eid = e["eid"];
//       employees.name = e["name"];

//       employee.add(employees);
//     }
//     return employee;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text("All Employees Details"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => employeeDrawer()));
//           },
//         ),
//       ),
//       body: Container(
//         child: FutureBuilder(
//           future: getEmployees(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.data == null) {
//               return Container(child: Center(child: Icon(Icons.error)));
//             }
//             return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text('ID' + ' ' + 'Name'),
//                     subtitle: Text('${snapshot.data[index].eid}' +
//                         '${snapshot.data[index].name}'),
//                     // onTap: () {
//                     //   Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //           builder: (context) =>
//                     //               DetailPage(snapshot.data[index])));
//                     // },
//                   );
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }

// // class DetailPage extends StatelessWidget {
// //   EmployeeModel employee;

// //   DetailPage(this.employee);

// //   deleteEmployee1(EmployeeModel employee) async {
// //     final url = Uri.parse('http://localhost:8080/deleteemployee');
// //     final request = http.Request("DELETE", url);
// //     request.headers
// //         .addAll(<String, String>{"Content-type": "application/json"});
// //     request.body = jsonEncode(employee);
// //     final response = await request.send();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(employee.firstName),
// //         actions: <Widget>[
// //           IconButton(
// //               icon: Icon(
// //                 Icons.edit,
// //                 color: Colors.white,
// //               ),
// //               onPressed: () {
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => updateEmployee(employee)));
// //               })
// //         ],
// //       ),
// //       body: Container(
// //         child: Text('FirstName' +
// //             ' ' +
// //             employee.firstName +
// //             ' ' +
// //             'LastName' +
// //             employee.lastName),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           deleteEmployee1(employee);
// //           Navigator.push(context,
// //               MaterialPageRoute(builder: (context) => deleteEmployee()));
// //         },
// //         child: Icon(Icons.delete),
// //         backgroundColor: Colors.pink,
// //       ),
// //     );
// //   }
// // }