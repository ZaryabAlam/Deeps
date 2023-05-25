import 'package:deeps/Utils/logOut.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final user = FirebaseAuth.instance.currentUser!;
  // bool _showIndicator = false;

  // void initState() {
  //   super.initState();
  //   _startLoading();
  // }

  // void _startLoading() {
  //   setState(() {
  //     _showIndicator = true;
  //   });

  //   Future.delayed(Duration(seconds: 5), () {
  //     setState(() {
  //       _showIndicator = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("About", style: TextStyle(color: Colors.black)),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Logout(context);
        //     },
        //     child: Icon(
        //       Icons.logout_rounded,
        //       size: 30,
        //     ),
        //   ),
        // ],
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Center(
                child: CircularProgressIndicator()); // 👈 user is loading
          }
          final user = snapshot.data;
          final uid = user?.uid; // 👈 get the UID
          if (user != null) {
            // print(user);

            CollectionReference users =
                FirebaseFirestore.instance.collection('users');

            return FutureBuilder<DocumentSnapshot>(
              future: users.doc(uid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Stack(
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "About User",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipscing elit, sed do tempor",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              SizedBox(height: 80),
                              Container(
                                height: 500,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 5,
                                          blurRadius: 15)
                                    ],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(35),
                                        topLeft: Radius.circular(35))),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 80),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        iconBox(FontAwesomeIcons.user),
                                        SizedBox(width: 10),
                                        detailBox(data['userName']),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        iconBox(FontAwesomeIcons.at),
                                        SizedBox(width: 10),
                                        detailBox(data['email']),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        iconBox(FontAwesomeIcons.idBadge),
                                        SizedBox(width: 10),
                                        detailBox(data['uId']),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      height: 50,
                                      width: 100,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            primary: Colors.white,
                                            backgroundColor: Colors.amber,
                                            minimumSize: Size.fromHeight(70)),
                                        onPressed: () {
                                          Logout(context);
                                        },
                                        child: Text(
                                          "Log out",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                                child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 3, color: Colors.black12)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        // child: imageBox(data['imagepath']),
                                        // child: _showIndicator
                                        //     ? Padding(
                                        //         padding: const EdgeInsets.all(40),
                                        //         child: CircularProgressIndicator(
                                        //             color: Colors.black38),
                                        //       )
                                        //     : imageBox(data['imagepath']),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(45),
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 5,
                                                  color: Colors.black),
                                            ),
                                            imageBox(data['imagepath']),
                                          ],
                                        )))),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.black,
                      ),
                      Text("loading")
                    ],
                  ),
                );
              },
            );
          } else {
            return Text("user is not logged in");
          }
        },
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
  Container imageBox(img1) {
    return Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(img1)),
        ));
  }

  Container detailBox(text1) {
    return Container(
      height: 56,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 2,
              color: Colors.grey //                   <--- border width here
              ),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text1,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left)),
      ),
    );
  }

  Container iconBox(FAicon) {
    return Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: FaIcon(
          FAicon,
          size: 36,
          color: Colors.white,
        )));
  }
}
