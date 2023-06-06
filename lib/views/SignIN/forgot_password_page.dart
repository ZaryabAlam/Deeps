import 'package:deeps/views/signIn/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/loaderDialog.dart';
import '../../Utils/mySnackbar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  var _numberForm = GlobalKey<FormState>();
  bool isValidForm = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    // final _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
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
                          "Reset Password",
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
                  child: Form(
                    key: _numberForm,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(height: 80),
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
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 30.0),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.black38),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(80))),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: _h * 0.09,
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
                                  if (_numberForm.currentState!.validate()) {
                                    setState(() {
                                      isValidForm = true;
                                      isLoading = true;
                                      showLoaderDialog(context);
                                      resetPassword();
                                    });
                                  } else {
                                    setState(() {
                                      isValidForm = false;
                                    });
                                  }
                                },
                                child: Text("Reset Password")),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Receive an Email Link to reset your password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
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

  Future resetPassword() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
      navigator!.pop();
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.to(() => SignIn());
      Get.showSnackbar(mySnackbar("Reset Link has been sent!", Colors.green,
          Icons.check_circle_rounded));
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(mySnackbar('Reset Failed! Email doesn\'t exist',
          Colors.red, Icons.warning_rounded));
      print(e);
    }
  }
}
