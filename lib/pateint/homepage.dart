import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/main.dart';
import 'package:tealth_project/pateint/home_icon_buttoms.dart';
import 'package:tealth_project/pateint/pateintProfile.dart';
import '../model/user_model.dart';
import '../widgets/bottombar.dart';
import 'package:intl/intl.dart';

class HomeScreenPateint extends StatefulWidget {
  const HomeScreenPateint({Key? key}) : super(key: key);

  @override
  _HomeScreenPateintState createState() => _HomeScreenPateintState();
}

class _HomeScreenPateintState extends State<HomeScreenPateint> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final primaryColor = const Color(0xff0095FF);
  final secondaryColor = const Color(0xff0095FF);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
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

  @override
  Widget build(BuildContext context) {
    String _message = "";
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          _message = 'Good Morning';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'Good Afternoon';
        } else {
          _message = 'Good Evening';
        }
      },
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                origin: Offset(30, -60),
                angle: 2.4,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 75,
                    top: 40,
                  ),
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: [Color(0xff0095FF), Color(0xff0095FF)],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${loggedInUser.firstName} ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 90),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'assets/File_dock_fill.png',
                                text: 'Examinations',
                                color: Color(0xFF47B4FF),
                              ),
                              CatigoryW(
                                image: 'assets/OQ6UTW0.png',
                                text: 'Find Doctor',
                                color: Color(0xFF47B4FF),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CatigoryW(
                                image: 'assets/erlenmeyer 1.png',
                                text: 'Find Lab',
                                color: Color(0xFF47B4FF),
                              ),
                              CatigoryW(
                                image: 'assets/Date_range.png',
                                text: 'Appointments',
                                color: Color(0xFF47B4FF),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}
