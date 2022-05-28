// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/rendering.dart';
//
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tealth_project/Lab/updateData.dart';
// import 'package:tealth_project/model/user_model.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DoctorProfile extends StatefulWidget {
//   const DoctorProfile() : super();
//   @override
//   _DoctorProfileState createState() => _DoctorProfileState();
// }
//
// class _DoctorProfileState extends State<DoctorProfile> {
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         // child: StreamBuilder(
//         //   stream: FirebaseFirestore.instance
//         //       .collection('users')
//         //       .orderBy('firstName')
//         //       .startAt([widget.patient]).endAt(
//         //           [widget.patient + '\uf8ff']).snapshots(),
//         //   builder:
//         //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         //     if (!snapshot.hasData) {
//         //       return Center(
//         //         child: CircularProgressIndicator(),
//         //       );
//         //     }
//         //     return NotificationListener<OverscrollIndicatorNotification>(
//         //       onNotification: (OverscrollIndicatorNotification overscroll) {
//         //         overscroll.disallowGlow();
//         //         return true;
//         //       },
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             return Container(
//               margin: EdgeInsets.only(top: 5),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     height: 50,
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(left: 5),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.chevron_left_sharp,
//                         color: Colors.indigo,
//                         size: 30,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   CircleAvatar(
//                     backgroundImage: NetworkImage("${loggedInUser.imageUrl}"),
//                     //backgroundColor: Colors.lightBlue[100],
//                     radius: 80,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "${loggedInUser.firstName} ",
//                     style: GoogleFonts.lato(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Icon(Icons.account_circle_outlined),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width / 1.4,
//                           child: Text(
//                             "${loggedInUser.id} ",
//                             style: GoogleFonts.lato(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Icon(Icons.email),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width / 1.4,
//                           child: Text(
//                             "${loggedInUser.email} ",
//                             style: GoogleFonts.lato(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     for (var i = 0; i < document['rating']; i++)
//                   //       Icon(
//                   //         Icons.star_rounded,
//                   //         color: Colors.indigoAccent,
//                   //         size: 30,
//                   //       ),
//                   //     if (5 - document['rating'] > 0)
//                   //       for (var i = 0; i < 5 - document['rating']; i++)
//                   //         Icon(
//                   //           Icons.star_rounded,
//                   //           color: Colors.black12,
//                   //           size: 30,
//                   //         ),
//                   //   ],
//                   // ),
//
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Icon(Icons.place_outlined),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width / 1.4,
//                           child: Text(
//                             "${loggedInUser.location} ",
//                             style: GoogleFonts.lato(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height / 12,
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Icon(Icons.phone),
//                         SizedBox(
//                           width: 11,
//                         ),
//                         Text(
//                           "${loggedInUser.phoneNumber} ",
//                           style: GoogleFonts.lato(
//                               fontSize: 16, color: Colors.black),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Icon(Icons.transgender),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width / 1.4,
//                           child: Text(
//                             "${loggedInUser.gender} ",
//                             style: GoogleFonts.lato(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Icon(Icons.access_time_rounded),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Working Hours',
//                           style: GoogleFonts.lato(
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     padding: EdgeInsets.only(left: 60),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Today: ',
//                           style: GoogleFonts.lato(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "${loggedInUser.StartWorkTime} " +
//                               " - " +
//                               "${loggedInUser.EndWorkTime} ",
//                           style: GoogleFonts.lato(
//                             fontSize: 17,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   // Container(
//                   //   padding: EdgeInsets.symmetric(horizontal: 30),
//                   //   height: 50,
//                   //   width: MediaQuery.of(context).size.width,
//                   //   child: ElevatedButton(
//                   //     style: ElevatedButton.styleFrom(
//                   //       elevation: 2,
//                   //       primary: Colors.indigo.withOpacity(0.9),
//                   //       onPrimary: Colors.black,
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(32.0),
//                   //       ),
//                   //     ),
//                   //     onPressed: () {
//                   //       Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => BookingScreen(
//                   //             patient: document['name'],
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //     child: Text(
//                   //       'Book an Appointment',
//                   //       style: GoogleFonts.lato(
//                   //         color: Colors.white,
//                   //         fontSize: 16,
//                   //         fontWeight: FontWeight.bold,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
