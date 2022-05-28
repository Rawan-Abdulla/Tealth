import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tealth_project/consts/colors.dart';
import 'package:tealth_project/consts/constants.dart';
import 'package:tealth_project/doctor/barDr.dart';
import 'package:tealth_project/pateint/PatinetBar.dart';
import 'package:tealth_project/pateint/homepage.dart';
import 'package:tealth_project/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tealth_project/widgets/bar.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'Lab/LabHome.dart';
import 'model/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection('users');

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    // TextFormField emailField;
    // TextFormField passwordField;
    // Material loginButton;
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          filled: true,
          prefixIcon: Icon(Icons.email),
          labelText: 'Email Address',
          fillColor: Theme.of(context).backgroundColor),
    );

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final loginButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50));
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [
                        ColorsConsts.gradiendFStart,
                        ColorsConsts.gradiendLStart
                      ],
                      [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.20, 0.25],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
            ),
            Column(
                // color: Colors.white,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 80),
                            height: 100.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                              //  color: Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage("assets/TEALTH 2.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          // SizedBox(
                          //     height: 200,
                          //     child: Image.asset(
                          //       "assets/logo.png",
                          //       fit: BoxFit.contain,
                          //     )),
                          SizedBox(height: 45),
                          emailField,
                          SizedBox(height: 25),
                          passwordField,
                          SizedBox(height: 35),
                          loginButton,
                          SizedBox(height: 15),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Don't have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationScreen()));
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 132, 255),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ),
                  ),
                ]),
          ],
        )),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          Fluttertoast.showToast(msg: "Login Successful");
          final User? user = await _auth.currentUser;
          final userID = user?.uid;
          print(userID);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .get()
              .then((value) => setState(() {

                    if (value['role'] == 'Pateint') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => PateintBar()));
                    } else if (value['role'] == 'Doctor') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => barDr()));
                    } else if (value['role'] == 'Lab') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>  bar()));
                    }
                  }));
        }
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        if (kDebugMode) {
          print(error.code);
        }
      }
    }
  }
}
