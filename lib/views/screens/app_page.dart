import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Utils/logOut.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final user = FirebaseAuth.instance.currentUser!;
  Color Ecolor = Colors.grey.withOpacity(0.2);
  Color Gcolor = Colors.grey.withOpacity(0.2);
  Color Ocolor = Colors.grey.withOpacity(0.2);

  void checkLoginPlatform() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String provider = user.providerData[0].providerId;
      switch (provider) {
        case 'google.com':
          setState(() {
            Gcolor = Colors.amber;
          });
          print('Logged in with Google');
          break;
        case 'facebook.com':
          print('Logged in with Facebook');
          break;
        case 'twitter.com':
          print('Logged in with Twitter');
          break;
        case 'password':
          setState(() {
            Ecolor = Colors.amber;
          });
          print('Logged in with Email/Password');
          break;
        case 'phone':
          setState(() {
            Ocolor = Colors.amber;
          });
          print('Logged in with OTP');
          break;
        // // Add cases for other authentication providers as needed
        // default:
        //   print('Logged in with $provider');
        //   break;
      }
    } else {
      print('User is not logged in');
    }
  }

  @override
  initState() {
    super.initState();
    checkLoginPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.black)),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("User: ${user.email!}"),
            // Text("User ID: ${user.uid}"),
            SizedBox(height: 80),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Home",
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            // SizedBox(height: 20),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "You've logged in from:",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w200,
                      fontSize: 18),
                ),
                SizedBox(width: 0.8),
                PlatformIconBox(Ecolor, FontAwesomeIcons.solidEnvelopeOpen),
                PlatformIconBox(Gcolor, FontAwesomeIcons.google),
                PlatformIconBox(Ocolor, FontAwesomeIcons.commentSms)
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     title: Text("Home", style: TextStyle(color: Colors.black)),
    //     // centerTitle: true,
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     automaticallyImplyLeading: false,
    //     iconTheme: IconThemeData(color: Colors.black),
    //     // actions: [
    //     //   InkWell(
    //     //     onTap: () {
    //     //       Logout(context);
    //     //     },
    //     //     child: Icon(
    //     //       Icons.logout_rounded,
    //     //       size: 30,
    //     //     ),
    //     //   ),
    //     // ],
    //   ),
    //   body: StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState != ConnectionState.active) {
    //         return Center(
    //             child: CircularProgressIndicator()); // 👈 user is loading
    //       }
    //       final user = snapshot.data;
    //       final uid = user?.uid; // 👈 get the UID
    //       if (user != null) {
    //         // print(user);

    //         CollectionReference users =
    //             FirebaseFirestore.instance.collection('users');

    //         return FutureBuilder<DocumentSnapshot>(
    //           future: users.doc(uid).get(),
    //           builder: (BuildContext context,
    //               AsyncSnapshot<DocumentSnapshot> snapshot) {
    //             if (snapshot.hasError) {
    //               return Text("Something went wrong");
    //             }

    //             if (snapshot.hasData && !snapshot.data!.exists) {
    //               return Text("Document does not exist");
    //             }

    //             if (snapshot.connectionState == ConnectionState.done) {
    //               Map<String, dynamic> data =
    //                   snapshot.data!.data() as Map<String, dynamic>;
    //               return Column(
    //                 children: [
    //                   Text("Hello, ${data['userName']}"),
    //                   Text(data['password']),
    //                   Text(data['email']),
    //                   Text(data['uId']),
    //                 ],
    //               );
    //             }

    //             return Center(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   CircularProgressIndicator(
    //                     color: Colors.amber,
    //                   ),
    //                   Text("loading")
    //                 ],
    //               ),
    //             );
    //           },
    //         );
    //       } else {
    //         return Text("user is not logged in");
    //       }
    //     },
    //   ),
    // );
  }

  Container PlatformIconBox(color1, icon1) {
    return Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            color: color1, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: FaIcon(
          icon1,
          size: 20,
          color: Colors.white,
        )));
  }
}
