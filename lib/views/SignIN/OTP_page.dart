import 'package:flutter/material.dart';

import '../../Utils/loaderDialog.dart';
import '../../Utils/logOut.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  var _numberForm = GlobalKey<FormState>();
  bool isValidForm = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("One Time Password", style: TextStyle(color: Colors.black)),
        // centerTitle: true,
        elevation: 0,
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
                  child: Form(
                    key: _numberForm,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(height: 80),
                          TextFormField(
                            validator: (inputValue) {
                              if (inputValue!.isEmpty) {
                                return "Enter Phone";
                              } else if (inputValue.length < 10 ||
                                  inputValue.length > 10) {
                                return "Please Enter Correct Phone";
                              }
                              return null;
                            },
                            controller: emailController,
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _textFieldOTP(first: true, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: true),
                            ],
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
                                    onPressed: () {
                                      if (_numberForm.currentState!
                                          .validate()) {
                                        setState(() {
                                          isValidForm = true;
                                          isLoading = true;
                                          showLoaderDialog(context);
                                        });
                                      } else {
                                        setState(() {
                                          isValidForm = false;
                                        });
                                      }
                                    },
                                    child: Text("Send OTP")),
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
                                      if (_numberForm.currentState!
                                          .validate()) {
                                        setState(() {
                                          isValidForm = true;
                                          isLoading = true;
                                          showLoaderDialog(context);
                                        });
                                      } else {
                                        setState(() {
                                          isValidForm = false;
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool? first, last}) {
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
        child: TextField(
          autofocus: true,
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
}
