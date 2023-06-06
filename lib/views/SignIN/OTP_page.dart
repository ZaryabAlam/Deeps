import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../Utils/loaderDialog.dart';
import '../../Utils/mySnackbar.dart';
import '../dashboard.dart';
import '../signUp/Plateform_signup.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final phoneController = TextEditingController();
  final otp1 = TextEditingController();
  final otp2 = TextEditingController();
  final otp3 = TextEditingController();
  final otp4 = TextEditingController();
  final otp5 = TextEditingController();
  final otp6 = TextEditingController();
  String? otpController = "";
  var _numberForm = GlobalKey<FormState>();
  var _numberForm2 = GlobalKey<FormState>();
  bool isValidForm = false;
  bool isLoading = false;
  // late User? user;
  var user = FirebaseAuth.instance.currentUser;
  String? verificationID = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isButtonDisabled = false;
  int _countdown = 10;
  Timer? _countdownTimer;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text("One Time Password", style: TextStyle(color: Colors.black)),
        // centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Continue with Phone",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      SizedBox(height: 10),
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
              ],
            ),
            // Spacer(),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 120),
                Container(
                  height: _h * 0.90,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(height: 80),
                        Form(
                          key: _numberForm,
                          child: TextFormField(
                            validator: (inputValue) {
                              if (inputValue!.isEmpty) {
                                return "Enter Phone";
                              } else if (inputValue.length < 10 ||
                                  inputValue.length > 10) {
                                return "Please Enter Correct Phone";
                              }
                              return null;
                            },
                            controller: phoneController,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            autofocus: true,
                            decoration: InputDecoration(
                                prefixText: '+92 ',
                                prefixStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 30.0),
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: Colors.black38),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(80))),
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _numberForm2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _textFieldOTP(
                                  first: true, last: false, otp: otp1),
                              _textFieldOTP(
                                  first: false, last: false, otp: otp2),
                              _textFieldOTP(
                                  first: false, last: false, otp: otp3),
                              _textFieldOTP(
                                  first: false, last: false, otp: otp4),
                              _textFieldOTP(
                                  first: false, last: false, otp: otp5),
                              _textFieldOTP(
                                  first: false, last: true, otp: otp6),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: _h * 0.07,
                              width: _w * 0.40,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                      primary: Colors.white,
                                      backgroundColor: Colors.black,
                                      minimumSize: Size.fromHeight(70)),
                                  // onPressed: () {
                                  //   if (_numberForm.currentState!
                                  //       .validate()) {
                                  //     setState(() {
                                  //       isValidForm = true;
                                  //       isLoading = true;
                                  //       showLoaderDialog(context);
                                  //       loginWithPhone();
                                  //     });
                                  //   } else {
                                  //     setState(() {
                                  //       isValidForm = false;
                                  //     });
                                  //   }
                                  // },
                                  onPressed: _isButtonDisabled
                                      ? null
                                      : _startCountdown,
                                  child: Text(
                                      _isButtonDisabled
                                          ? '$_countdown'
                                          : "Send OTP",
                                      style: TextStyle(color: Colors.white))),
                            ),
                            Container(
                              height: _h * 0.07,
                              width: _w * 0.40,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80)),
                                      primary: Colors.white,
                                      backgroundColor: Colors.amber,
                                      minimumSize: Size.fromHeight(70)),
                                  onPressed: () {
                                    if (_numberForm2.currentState!.validate()) {
                                      setState(() {
                                        isValidForm = true;
                                        isLoading = true;
                                        showLoaderDialog(context);
                                        otpController = otp1.text +
                                            otp2.text +
                                            otp3.text +
                                            otp4.text +
                                            otp5.text +
                                            otp6.text;
                                        verifyOTP();
                                      });
                                    } else {
                                      setState(() {
                                        isValidForm = false;
                                        Get.showSnackbar(mySnackbar(
                                            "Enter the code!",
                                            Colors.red,
                                            Icons.warning_rounded));
                                      });
                                    }
                                  },
                                  child: Text("Verify Code")),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Receive a Code message on your phone number to verify it",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _startCountdown() {
    setState(() {
      if (_numberForm.currentState!.validate()) {
        setState(() {
          _isButtonDisabled = true;
          _countdown = 10;
          isValidForm = true;
          isLoading = true;
          showLoaderDialog(context);
          loginWithPhone();
        });
      } else {
        setState(() {
          isValidForm = false;
        });
      }
    });
    // setState(() {
    //   _isButtonDisabled = true;
    //   _countdown = 10;

    // });

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _isButtonDisabled = false;
          timer.cancel();
        }
      });
    });
  }

  Widget _textFieldOTP(
      {bool? first, last, required TextEditingController otp}) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(
              0.0,
              2.0,
            ),
          )
        ],
      ),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextFormField(
          autofocus: true,
          validator: (inputValue) {
            if (inputValue!.isEmpty) {
              return "";
            }
            return null;
          },
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          controller: otp,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.black.withOpacity(0.04),
                ),
                borderRadius: BorderRadius.circular(25)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  Future loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+92" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("THIS IS TEST1");
        try {
          await auth.signInWithCredential(credential).then((value) {
            print("THIS IS TEST2");
          });
        } on FirebaseAuthException catch (e) {
          Get.showSnackbar(mySnackbar("Failed to send Code! Please try again",
              Colors.red, Icons.warning_rounded));
          print(e.toString());
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          isLoading = false;
          navigator!.pop();
        });
        Get.showSnackbar(mySnackbar("Failed to send Code! Please try again",
            Colors.red, Icons.warning_rounded));
        // print("THIS IS TEST3");
        // print(e.message);
        // Get.showSnackbar(mySnackbar("Failed to send Code! Please try again",
        //     Colors.red, Icons.warning_rounded));
      },
      codeSent: (verificationId, resendToken) {
        setState(() {
          isLoading = false;
          navigator!.pop();
        });
        // print("THIS IS TEST4");
        Get.showSnackbar(
            mySnackbar("Code Sent!", Colors.green, Icons.check_circle_rounded));
        // otpVisibility = true;
        verificationID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future verifyOTP() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
      navigator!.pop();
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: otpController.toString());

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser!;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          // Get.showSnackbar(mySnackbar(
          //     "Sign in Successful!", Colors.green, Icons.check_circle_rounded));
          checkDocumentExists();

          // Get.to(() => Dashboard());
        } else {
          Get.showSnackbar(mySnackbar("Login Failed! Please try again",
              Colors.red, Icons.warning_rounded));
        }
      },
    );
  }

  Future<void> checkDocumentExists() async {
    final user = FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Get.showSnackbar(mySnackbar(
          "Sign in Successful!", Colors.green, Icons.check_circle_rounded));
      // print('Document exists');
      // print(uid);
      Get.to(() => Dashboard());
      // Perform actions if document exists
    } else {
      Get.showSnackbar(mySnackbar("Complete the form to Sign In!",
          Colors.greenAccent, Icons.check_circle_rounded));
      // print('Document does not exist');
      // print(uid);
      Get.to(() => PlateformSignup());
    }
  }
}
