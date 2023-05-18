import 'package:deeps/views/app_page.dart';
import 'package:deeps/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//test
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("No Internet Connection!"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              // scaffoldMessengerKey: Utils.messengerKey,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                // body: Signup(),
                body: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Something went wrong!"));
                      } else if (snapshot.hasData) {
                        return AppPage();
                      } else {
                        return Home();
                      }
                    }),
              ),
            );
          }
          return Container(
            child: Text("WAIT! Loading..."),
          );
        });

    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: true,
    //   home: Scaffold(
    //     body: StreamBuilder<User?>(
    //         stream: FirebaseAuth.instance.authStateChanges(),
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             return AppPage();
    //           } else {
    //             return Home();
    //           }
    //           // return Home();
    //         }),
    //   ),
    // );
  }
}
