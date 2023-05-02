import 'package:deeps/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _numberForm = GlobalKey<FormState>();
  bool isValidForm = false;
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
                Get.to(SignIn());
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
                              // SizedBox(height: 10),
                              TextFormField(
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return "Enter Email";
                                  }
                                  return null;
                                },
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
                                  }
                                  return null;
                                },
                                cursorColor: Colors.black,
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 30.0),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.black38),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
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
                                          isValidForm = true;
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
}
