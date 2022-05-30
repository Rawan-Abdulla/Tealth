import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/pateint/AIAdivce.dart';
import 'package:tealth_project/pateint/home_icon_buttoms.dart';
import '../model/user_model.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Stack(
              children: [
                Transform.rotate(
                  origin: Offset(30, -60),
                  angle: 2.4,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 75,
                      top: 10,
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
                Container(
                    padding: EdgeInsets.only(top: 40, left: 300),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Image.asset("assets/AiAdv.png"),
                          onPressed: () {
                            showAlert(context);
                          },
                          iconSize: 90.0,
                          autofocus: true,
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
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
                        padding: EdgeInsets.only(top: 40),
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
      ),
    );
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Image.network(
              'https://flutter-examples.com/wp-content/uploads/2019/12/android_icon.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            Text(' Heart Disease Detection ')
          ]),
          content: Text(
              "Do you want to predict whether you have heart disease or not?"),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AiForm(title: "Ai Prediction Form")),
                );
              },
            ),
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
