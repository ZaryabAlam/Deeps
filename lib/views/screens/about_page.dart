import 'package:deeps/Utils/logOut.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final user = FirebaseAuth.instance.currentUser!;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Stack(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About User",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipscing elit, sed do tempor",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconBox(FontAwesomeIcons.user),
                              SizedBox(width: 10),
                              detailBox("Name"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconBox(FontAwesomeIcons.at),
                              SizedBox(width: 10),
                              detailBox("Email"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconBox(FontAwesomeIcons.idBadge),
                              SizedBox(width: 10),
                              detailBox("123456789987654321"),
                            ],
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
                              border:
                                  Border.all(width: 3, color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: imageBox(),
                          ))),
                ),
              ],
            ),
          ),
        ));
  }

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
  Container imageBox() {
    return Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://us.123rf.com/450wm/rmagfx/rmagfx2304/rmagfx230400075/202352006-a-close-up-of-a-cute-cat-with-a-smiling-expression-generative-ai.jpg?ver=6"))));
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
