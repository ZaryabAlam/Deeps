import 'package:deeps/Utils/mySnackbar.dart';
import 'package:deeps/views/dashboard.dart';
import 'package:deeps/views/home.dart';
import 'package:deeps/views/SignIN/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../../Utils/loaderDialog.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final userNameController = TextEditingController();
  var _numberForm = GlobalKey<FormState>();
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  var imagepath = "";
  bool isValidForm = false;
  bool isObscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    // final _w = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.amber,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => SignIn());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => new Home()),
                // );
              },
              child: TextButton(
                  onPressed: null,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign Up",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipscing elit, sed do tempor",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 450,
                  // height: _h * 0.75,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5,
                            blurRadius: 15)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35))),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Form(
                        key: _numberForm,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                  elevation: 0,
                                  child: _photo != null
                                      ? Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: FileImage(_photo!),
                                                  fit: BoxFit.cover)),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _showPicker(context);
                                          },
                                          child: Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey.shade200),
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.solidImages,
                                                  size: 36,
                                                  color: Colors.black45,
                                                ),
                                              ))
                                          // child: Image.network(
                                          //   "https://static.thenounproject.com/png/3322766-200.png",
                                          //   height: 120,
                                          // ),
                                          )),
                              SizedBox(height: 10),
                              TextFormField(
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return "Enter Email";
                                  } else if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(inputValue)) {
                                    return "Please Enter Correct Email";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 30.0),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.black38),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(80))),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return "Enter username";
                                  }
                                  return null;
                                },
                                controller: userNameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 30.0),
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.black38),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(80))),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return "Enter password";
                                  } else if (inputValue.length < 6) {
                                    return "Enter at least 6 letters";
                                  }
                                  return null;
                                },
                                controller: passController,
                                cursorColor: Colors.black,
                                obscureText: isObscure,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 30.0),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.black38),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    suffixIcon: IconButton(
                                        color: (isObscure
                                            ? Colors.grey
                                            : Colors.amber),
                                        icon: Icon(isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            isObscure = !isObscure;
                                          });
                                        }),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(80))),
                              ),
                              // SizedBox(height: 10),

                              SizedBox(height: 20),
                              Container(
                                height: _h * 0.08,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80)),
                                        primary: Colors.white,
                                        backgroundColor: Colors.black,
                                        minimumSize: Size.fromHeight(70)),
                                    onPressed: () {
                                      if (_numberForm.currentState!
                                          .validate()) {
                                        setState(() {
                                          signUp(context);
                                          isLoading = true;
                                          isValidForm = true;
                                          showLoaderDialog(context);
                                          // Get.to(() => Home());
                                        });
                                      } else {
                                        setState(() {
                                          isValidForm = false;
                                        });
                                      }
                                    },
                                    child: Text("Sign Up")),
                              ),
                              SizedBox(height: 40),
                              GestureDetector(
                                onTap: () async {
                                  const url =
                                      'https://accounts.google.com/v3/signin/identifier?dsh=S-251231302%3A1663782779691460&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F%26ogbl%2F&emr=1&ltmpl=default&ltmplcache=2&osid=1&passive=true&rm=false&scc=1&service=mail&ss=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin&ifkv=AQDHYWov1HYEBHuWBN_m80xuHQYWeafjv3SjrJPJWHgKO0hkWIU7vbUzR1H1up9hCzvJK9h74UO5iw';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  height: _h * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 15,
                                        offset: const Offset(
                                          0.0,
                                          6.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/google.png"))),
                                      ),
                                      Text("Continue with Google"),
                                      Icon(Icons.keyboard_arrow_right)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                splashColor: Colors.green,
                                onTap: () async {
                                  const url = 'https://www.facebook.com/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  height: _h * 0.08,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 15,
                                        offset: const Offset(
                                          0.0,
                                          6.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/facebook.png"))),
                                      ),
                                      Text("Continue with Facebook"),
                                      Icon(Icons.keyboard_arrow_right)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  // Future signUp() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   setState(() {
  //     isLoading = false;
  //     navigator!.pop();
  //   });
  //   // showDialog(
  //   //     context: context,
  //   //     barrierDismissible: false,
  //   //     builder: ((context) => Center(
  //   //           child: CircularProgressIndicator(),
  //   //         )));
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passController.text.trim());
  //     Get.to(() => AppPage());
  //     Get.showSnackbar(mySnackbar(
  //         "Signup Successful!", Colors.green, Icons.check_circle_rounded));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "email-already-in-use") {
  //       Get.showSnackbar(const GetSnackBar(
  //         margin: EdgeInsets.all(15),
  //         icon: Icon(Icons.warning_rounded, color: Colors.white),
  //         borderRadius: 8,
  //         message: ('An account already exist with the given email address'),
  //         duration: Duration(seconds: 3),
  //         backgroundColor: Colors.red,
  //       ));
  //     }
  //     // Utils.showSnackBar(e.message);
  //     else {
  //       Fluttertoast.showToast(
  //           msg: 'Signup Failed',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           backgroundColor: Colors.red.shade300,
  //           textColor: Colors.white);
  //     }
  //     print(e);
  //   }
  // }

  Future<bool?> signUp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
      navigator!.pop();
    });
    if (imagepath == "") {
      setState(() {
        isLoading = false;
      });
      Get.showSnackbar(mySnackbar(
          "Please upload an image", Colors.orange, Icons.cancel_rounded));
      print("Image not found");
    } else {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passController.text.trim());

        //if user creation is success, create a user model
        if (credential.user == null) return false;

        Map<String, dynamic> user = {
          "uId": credential.user!.uid.toString(),
          "userName": userNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passController.text.trim(),
          "imagepath": imagepath,
        };

        //and upload user model to firebase
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user)
            .then((value) {
          Get.showSnackbar(mySnackbar(
              "Signup Successful!", Colors.green, Icons.check_circle_rounded));
          Get.to(() => Dashboard());
        });
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          Get.showSnackbar(mySnackbar(
              "An account already exist with the given email address",
              Colors.red,
              Icons.warning_rounded));
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong. Try again',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red.shade300,
              textColor: Colors.white);
        }
        print(e);
        return false;
      }
    }
    return null;
  }

  void _showPicker(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 220,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Wrap(
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            imgFromGallery();
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade600,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.solidFileImage,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            imgFromCamera();
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade600,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.cameraRetro,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black45,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // ListTile(
                //     leading: const Icon(Icons.photo_library),
                //     title: const Text('Gallery'),
                //     onTap: () {
                //       imgFromGallery();
                //       Navigator.of(context).pop();
                //     }),
                // ListTile(
                //   leading: const Icon(Icons.photo_camera),
                //   title: const Text('Camera'),
                //   onTap: () {
                //     imgFromCamera();
                //     Navigator.of(context).pop();
                //   },
                // ),
              ],
            ),
          );
        });
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/${fileName}';

    try {
      Reference reference =
          FirebaseStorage.instance.ref().child(destination).child(fileName);

      TaskSnapshot storageTaskSnapshot = await reference.putFile(_photo!);

      print(storageTaskSnapshot.ref.getDownloadURL());

      var dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
      print(dowUrl);

      imagepath = dowUrl;
      setState(() {});
    } catch (e) {
      print('error occured');
    }
  }
}
