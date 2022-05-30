import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tealth_project/consts/colors.dart';
import 'package:tealth_project/doctor/barDr.dart';
import 'package:tealth_project/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tealth_project/pateint/PatinetBar.dart';
import 'package:tealth_project/lab/bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final roleEditingController = new TextEditingController();
  final idEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final locationEditingController = new TextEditingController();

  final ageEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final specialistDoctorEditingController = new TextEditingController();
  // ignore: unused_field
  File? imageFile;
  late String Imageurl;
  Image profileImage = Image.asset('assets/defult_doctor.png');
  // GlobalMethods _globalMethods = GlobalMethods();

  bool isVisible = false;
  bool isVisiblePateint = false;
  bool isVisibleDoctor = false;
  bool isVisibleLab = false;
  String selectedStartTime = '8:00 AM';
  String selectedEndTime = '4:00 PM';

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imageFile = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imageFile = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      imageFile = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //for all users
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //for pateints

    final idField = TextFormField(
        autofocus: false,
        controller: idEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{9,}$');
          if (value!.isEmpty) {
            return ("id cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid id");
          }
          return null;
        },
        onSaved: (value) {
          idEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "ID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //////   age field

    final ageField = TextFormField(
        autofocus: false,
        controller: ageEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{2,}$');
          if (value!.isEmpty) {
            return ("age cannot be Empty");
          }

          return null;
        },
        onSaved: (value) {
          ageEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Age",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // phoneNumberField

    final phoneNumberField = TextFormField(
        autofocus: false,
        controller: phoneNumberEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{10,}$');
          if (value!.isEmpty) {
            return ("phone number cannot be Empty");
          }

          return null;
        },
        onSaved: (value) {
          phoneNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //genderFeiled field
    final genderFeiled = Material(
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItems: true,
          items: ["Female", "Male"],
          label: "Gender",
          hint: "Your Gender ?",
          onChanged: (val) {
            genderEditingController.text = val!;
          },
          selectedItem: "Select"),
    );
    final locationFeiled = Material(
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItems: true,
          items: [
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
          label: "Location",
          hint: "Your Location ?",
          onChanged: (val) {
            locationEditingController.text = val!;
          },
          selectedItem: "Select"),
    );

    /// DOCTOR SECTION
    // start timebutton
    Future<void> _openTimePicker(BuildContext context) async {
      final TimeOfDay? t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (t != null) {
        setState(() {
          selectedStartTime = t.format(context);
        });
      }
    }

    final startTimeButton = Material(
      color: Colors.blue,
      child: RawMaterialButton(
        child: Text(
          selectedStartTime,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          _openTimePicker(context);
        },
      ),
    );
    //end time button
    Future<void> openTimePicker(BuildContext context) async {
      final TimeOfDay? t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (t != null) {
        setState(() {
          selectedEndTime = t.format(context);
        });
      }
    }

    final endTimeButton = Material(
      color: Colors.blue,
      child: RawMaterialButton(
        child: Text(
          selectedEndTime,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          openTimePicker(context);
        },
      ),
    );
    final specialistDoctorField = Material(
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItems: true,
          items: [
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
          label: "Specialist",
          hint: "Your specialist ?",
          onChanged: (val) {
            specialistDoctorEditingController.text = val!;
          },
          selectedItem: "Select"),
    );
    // specialistDoctor

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final roleFeiled = Material(
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItems: true,
          items: ["Pateint", "Doctor", "Lab"],
          label: "Role",
          hint: "Your role ?",
          onChanged: (val) {
            roleEditingController.text = val!;
            isVisibleDoctor = false;
            isVisibleLab = false;
            isVisiblePateint = false;
          },
          selectedItem: "Select"),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        child: CircleAvatar(
                          radius: 71,
                          backgroundColor: ColorsConsts.gradiendLEnd,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: ColorsConsts.gradiendFEnd,
                            backgroundImage: imageFile == null
                                ? null
                                : FileImage(imageFile!),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 120,
                          left: 110,
                          child: RawMaterialButton(
                            elevation: 10,
                            fillColor: ColorsConsts.gradiendLEnd,
                            child: Icon(Icons.add_a_photo),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Choose option',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: ColorsConsts.gradiendLStart),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                              onTap: _pickImageCamera,
                                              splashColor: Colors.purpleAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.camera,
                                                      color:
                                                          Colors.purpleAccent,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            ColorsConsts.title),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _pickImageGallery,
                                              splashColor: Colors.purpleAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.image,
                                                      color:
                                                          Colors.purpleAccent,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            ColorsConsts.title),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _remove,
                                              splashColor: Colors.purpleAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          )),
                    ],
                  ),
                  // SizedBox(height: 45),
                  firstNameField,

                  SizedBox(height: 20),
                  emailField,
                  SizedBox(height: 20),
                  passwordField,
                  SizedBox(height: 20),
                  confirmPasswordField,
                  // SizedBox(height: 20),
                  // startTimeButton,
                  SizedBox(height: 20),
                  roleFeiled,
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        child: Text('Next'),
                        onPressed: () {
                          if (roleEditingController.text == 'Pateint') {
                            setState(() {
                              isVisibleDoctor = false;
                              isVisibleLab = false;

                              isVisiblePateint = !isVisiblePateint;
                            });
                          }
                          if (roleEditingController.text == 'Doctor') {
                            setState(() {
                              isVisibleLab = false;
                              isVisiblePateint = false;

                              isVisibleDoctor = !isVisibleDoctor;
                            });
                          }
                          if (roleEditingController.text == 'Lab') {
                            setState(() {
                              isVisibleDoctor = false;

                              isVisiblePateint = false;

                              isVisibleLab = !isVisibleLab;
                            });
                          }
                        },
                      ),
                      Visibility(
                          visible: isVisiblePateint,
                          child: Column(
                            children: [
                              SizedBox(height: 45),
                              idField,
                              SizedBox(height: 20),
                              genderFeiled,
                              SizedBox(height: 20),
                              ageField,
                              SizedBox(height: 20),
                              phoneNumberField,
                              SizedBox(height: 20),
                              signUpButton,
                            ],
                          )),
                      Visibility(
                          visible: isVisibleDoctor,
                          child: Column(
                            children: [
                              SizedBox(height: 45),
                              Text("working Time"),
                              SizedBox(height: 20),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    startTimeButton,
                                    SizedBox(width: 20),
                                    endTimeButton,
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              specialistDoctorField,
                              SizedBox(height: 20),
                              locationFeiled,
                              SizedBox(height: 20),
                              genderFeiled,
                              SizedBox(height: 20),
                              ageField,
                              SizedBox(height: 20),
                              phoneNumberField,
                              SizedBox(height: 20),
                              signUpButton,
                            ],
                          )),
                      Visibility(
                          visible: isVisibleLab,
                          child: Column(
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    startTimeButton,
                                    SizedBox(width: 20),
                                    endTimeButton,
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              locationFeiled,
                              SizedBox(height: 20),
                              phoneNumberField,
                              SizedBox(height: 20),
                              signUpButton,
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      if (imageFile == null) {
        // _globalMethods.authErrorHandle('Please pick an image', context);
      } else {
        FirebaseStorage storage = FirebaseStorage.instance;
        final ref = FirebaseStorage.instance
            .ref()
            .child('usersImages')
            .child(firstNameEditingController.text + '.jpg');
        await ref.putFile(imageFile!);
        Imageurl = await ref.getDownloadURL();
      }
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
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
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.role = roleEditingController.text;
    userModel.id = idEditingController.text;
    userModel.gender = genderEditingController.text;
    //userModel.age = ageEditingController.text;
    userModel.phoneNumber = phoneNumberEditingController.text;
    userModel.StartWorkTime = selectedStartTime;
    userModel.EndWorkTime = selectedEndTime;
    userModel.imageUrl = Imageurl;
    userModel.location = locationEditingController.text;

    String imagePath;
    var uid = user.uid;

    var storageRef = storage.ref().child("profile_images/$uid");

    var uploadImage = storageRef.putFile(File(imageFile!.path));

    var completedUpload = await uploadImage.whenComplete(() async {});

    await storage
        .ref()
        .child("profile_images/$uid")
        .getDownloadURL()
        .then((url) => {Imageurl = url});

    userModel.imageUrl = Imageurl;
    print('dowanload url is here');
    print(Imageurl);

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) => setState(() {
              if (roleEditingController.text == 'Pateint') {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PateintBar()));
              } else if (roleEditingController.text == 'Doctor') {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => barDr()));
              } else if (roleEditingController.text == 'Lab') {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => bar()));
              }
            }));
    ;
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }
}
