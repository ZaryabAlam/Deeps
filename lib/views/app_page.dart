import 'package:deeps/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
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
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png")),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Home",
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
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
