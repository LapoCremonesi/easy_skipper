import 'dart:convert';

import 'package:easy_skipper/page/user_page.dart';
import 'package:easy_skipper/widget/custom_user.dart';
import 'package:easy_skipper/widget/homepage_box_view.dart';
import 'package:easy_skipper/widget/homepage_tile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final CustomUser user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool isListView = true;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    //use strapi to save user info
    if (state == AppLifecycleState.paused) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      await http.put(
        Uri.parse(
          "http://192.168.1.100:1337/api/profiles?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}",
        ),
        headers: headers,
        body: jsonEncode(
          {
            "data": {
              "isListView": isListView,
            },
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text("HomePage"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserPage(),
                ),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: 60,
              width: width,
              margin: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.search),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isListView = true;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isListView ? Colors.red : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.view_list_rounded,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isListView = false;
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      color: !isListView ? Colors.red : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    child: const Center(
                      child: Icon(
                        Icons.grid_3x3_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 300 *
                    ((height - 100 - 60 - 20 - 30 - 10 - statusBarHeight) /
                        300),
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return isListView
                        ? const HomePageTileView()
                        : const Row(
                            children: [
                              HomePageBoxView(),
                              HomePageBoxView(),
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
