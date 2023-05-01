import 'package:deeps/views/extra.dart';
import 'package:deeps/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _numberForm = GlobalKey<FormState>();
  bool isValidForm = false;
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
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(SignUp());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => new Home()),
                // );
              },
              child: TextButton(
                  onPressed: null,
                  child: Text(
                    "Register",
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign In",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 10),
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
            Container(
              height: _h * 0.70,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 5, blurRadius: 15)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35))),
              child: Form(
                key: _numberForm,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (inputValue) {
                          if (inputValue.isEmpty) {
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
                                borderRadius: BorderRadius.circular(80))),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        validator: (inputValue) {
                          if (inputValue.isEmpty) {
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
                                borderRadius: BorderRadius.circular(80))),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Get.to(Extra());
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: _h * 0.08,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                primary: Colors.white,
                                backgroundColor: Colors.black,
                                minimumSize: Size.fromHeight(70)),
                            onPressed: () {
                              if (_numberForm.currentState.validate()) {
                                setState(() {
                                  isValidForm = true;
                                });
                              } else {
                                setState(() {
                                  isValidForm = false;
                                });
                              }
                            },
                            child: Text("Sign In")),
                      ),
                      SizedBox(height: 50),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/google.png"))),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/facebook.png"))),
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
            )
          ],
        ));
  }
}
