import 'package:deeps/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
