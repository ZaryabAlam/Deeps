import 'package:deeps/Utils/mySnackbar.dart';
import 'package:deeps/views/dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../../Utils/loaderDialog.dart';
import '../../Utils/logOut.dart';

class PlateformSignup extends StatefulWidget {
  const PlateformSignup({super.key});

  @override
  State<PlateformSignup> createState() => _PlateformSignupState();
}

class _PlateformSignupState extends State<PlateformSignup> {
  final user = FirebaseAuth.instance.currentUser!;
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  var _numberForm = GlobalKey<FormState>();
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  var imagepath = "";
  bool isValidForm = false;
  bool isLoading = false;
  String? emailOrphone = "";

  Future<void> showUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.providerData[0].providerId == 'google.com') {
        // User logged in with email
        emailOrphone = user.email;
        print('emailOrpassword: $emailOrphone');
      } else if (user.providerData[0].providerId == 'phone') {
        // User logged in with phone number
        emailOrphone = user.phoneNumber;
        print('emailOrpassword: $emailOrphone');
      }
    } else {
      print('User is not logged in');
    }
  }

  @override
  initState() {
    super.initState();
    // checkemailOrphone();
    showUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    // final _w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text("Details", style: TextStyle(color: Colors.black)),
          // centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            InkWell(
              onTap: () {
                Logout(context);
              },
              child: Icon(
                Icons.logout_rounded,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipscing elit, sed do tempor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 500,
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
                      shrinkWrap: true,
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
                                                    color:
                                                        Colors.grey.shade200),
                                                child: Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidImages,
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
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(80)),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(emailOrphone.toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black38))),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 30.0),
                                      hintText: "Username",
                                      hintStyle:
                                          TextStyle(color: Colors.black38),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(80))),
                                ),
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
                                            uploadDetails(context);
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
                                      child: Text("Continue")),
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
          ),
        ));
  }
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

  Future<bool?> uploadDetails(BuildContext context) async {
    final user1 = FirebaseAuth.instance.currentUser!;
    if (_photo == null) {
      setState(() {
        isLoading = false;
      });
      Get.showSnackbar(mySnackbar(
          "Please upload an image", Colors.orange, Icons.cancel_rounded));
      print("Image not found");
    } else {
      try {
        await uploadFile();
        final credential = await FirebaseFirestore.instance
            .collection('users')
            .doc(user1.uid.toString());

        Map<String, dynamic> user = {
          "uId": user1.uid.toString(),
          "userName": userNameController.text.trim(),
          "email": emailOrphone.toString(),
          "imagepath": imagepath,
        };

        //and upload user model to firebase
        await Future.delayed(const Duration(seconds: 5));
        setState(() {
          isLoading = false;
          navigator!.pop();
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user1.uid.toString())
            .set(user)
            .then((value) {
          Get.showSnackbar(mySnackbar(
              "Signup Successful!", Colors.green, Icons.check_circle_rounded));
          Future.delayed(const Duration(seconds: 5));
          setState(() {
            isLoading = false;
            navigator!.pop();
          });
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

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

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
        // uploadFile();
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
        // uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'Images/${emailOrphone}';

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
