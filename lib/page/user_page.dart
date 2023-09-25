import 'dart:convert';
import 'package:easy_skipper/page/aggiungi_barca.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:easy_skipper/object/barca.dart';
import 'package:easy_skipper/widget/custom_barca_display.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.userProfile,
  });

  final CustomProfile userProfile;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Barche> barche = [];

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AggiungiBarca(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 250,
                  width: width / 2.5,
                  color: Colors.green,
                ),
                Container(
                  height: 250,
                  width: width - width / 2.5,
                  color: Colors.yellow,
                  child: Center(
                    child: Text(widget.userProfile.username),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: height - 250 - statusBarHeight - 5 - 56,
              width: width,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, _) {
                  return SizedBox(
                    height: 100.0 * barche.length,
                    child: ListView.builder(
                      itemCount: barche.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CustomBarcaDisplay(
                              barcaInfo: barche[index],
                            ),
                            const SizedBox(height: 5),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchAlbum() async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.1.100:1337/api/barche?filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}&populate=*',
      ),
    );

    int numeroBarche = jsonDecode(response.body)["meta"]["pagination"]["total"];

    if (response.statusCode == 200) {
      for (var i = 0; i < numeroBarche; i++) {
        setState(() {
          barche.add(
            Barche.fromJson(
              jsonDecode(response.body)["data"][i],
            ),
          );
        });
      }
    } else {
      throw Exception('Failed to load barche');
    }
  }
}
