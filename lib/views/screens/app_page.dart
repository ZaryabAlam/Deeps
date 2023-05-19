import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deeps/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     title: Text("Home", style: TextStyle(color: Colors.black)),
    //     // centerTitle: true,
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //     automaticallyImplyLeading: false,
    //     iconTheme: IconThemeData(color: Colors.black),
    //     actions: [
    //       InkWell(
    //         onTap: () {
    //           Logout(context);
    //         },
    //         child: Icon(
    //           Icons.logout_rounded,
    //           size: 30,
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       // crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Text("User: ${user.email!}"),
    //         Text("User ID: ${user.uid}"),
    //         SizedBox(height: 20),
    //         Container(
    //           height: 250,
    //           width: 250,
    //           decoration: BoxDecoration(
    //             image: DecorationImage(image: AssetImage("assets/logo.png")),
    //           ),
    //         ),
    //         SizedBox(height: 20),
    //         Text(
    //           "Home",
    //           style: TextStyle(
    //               color: Colors.black26,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 20),
    //         )
    //       ],
    //     ),
    //   ),
    // );
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
        // body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        //   stream: FirebaseFirestore.instance
        //       .collection('users')
        //       // .doc(FirebaseAuth.instance.currentUser?.uid)
        //       .snapshots(),
        //   builder: (_, snapshot) {
        //     if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        //     if (snapshot.hasData) {
        //       final docs = snapshot.data!.docs;
        //       return ListView.builder(
        //         itemCount: docs.length,
        //         itemBuilder: (_, i) {
        //           final data = docs[i].data();
        //           return ListTile(
        //             title: Text(data['name']),
        //             subtitle: Column(
        //               children: [
        //                 Text(data['password']),
        //                 Text(data['uId']),
        //               ],
        //             ),
        //           );
        //         },
        //       );
        //     }

        //     return Center(child: CircularProgressIndicator());
        //   },
        // )
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
                    return Column(
                      children: [
                        Text("Hello, ${data['userName']}"),
                        Text(data['password']),
                        Text(data['email']),
                        Text(data['uId']),
                      ],
                    );
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator(), Text("loading")],
                    ),
                  );
                },
              );
            } else {
              return Text("user is not logged in");
            }
          },
        ));
  }

  Future<dynamic> Logout(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Log out"),
              content: const Text("Are you sure to logout?"),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
                SizedBox(width: 05),
                IconButton(
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    Get.to(() => Home());
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
                // TextButton(
                //     onPressed: () async {
                //       Get.to(() => Home());
                //     },
                //     child: Text("Yes",
                //         style: TextStyle(color: Color(0xFF045a4f)))),

                // TextButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     child: const Text("No",
                //         style: TextStyle(color: Color(0xFF045a4f))))
              ],
            ));
  }
}
