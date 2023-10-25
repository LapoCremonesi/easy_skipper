import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/barca.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class BarcaInfo extends StatefulWidget {
  const BarcaInfo({
    super.key,
    required this.barcheInfo,
  });

  final Barche barcheInfo;

  @override
  State<BarcaInfo> createState() => _VisualizzaBarcaState();
}

class _VisualizzaBarcaState extends State<BarcaInfo> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 250 + statusBarHeight,
                  width: width,
                  decoration: BoxDecoration(
                    color: bluOceanoProfondo,
                    image: DecorationImage(
                      image: NetworkImage('$api${widget.barcheInfo.image.small}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: statusBarHeight + 10, left: 10),
                        decoration: const BoxDecoration(
                          color: arancioneBoa,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text("Nome Barca: ${widget.barcheInfo.nome}"),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text("Larghezza: ${widget.barcheInfo.larghezza}"),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text("Lunghezza: ${widget.barcheInfo.lunghezza}"),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 70,
                    width: width / 2 - 15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue.shade200,
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    child: Center(
                      child: SvgPicture.asset(
                        'images/pencil.svg',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => showConfirmDialog(),
                  child: Container(
                    height: 70,
                    width: width / 2 - 15,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.red,
                    ),
                    margin: const EdgeInsets.only(left: 5, right: 10),
                    child: const Center(
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future showConfirmDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Sicuro di eliminare la barca?",
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        deleteBarca();
                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width / 2 - 55,
                        margin: const EdgeInsets.only(left: 10, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Center(
                          child: Text(
                            'Si',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width / 2 - 55,
                        margin: const EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.red.shade300,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Center(
                          child: Text(
                            'No',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteBarca() async {
    final getID = await http.get(Uri.parse("$api/api/barche?filters[nome_barca][\$eq]=${widget.barcheInfo.nome}&filters[UID][\$eq]=${FirebaseAuth.instance.currentUser?.uid}"));
    final barcaID = jsonDecode(getID.body)["data"][0]["id"];

    await http.delete(Uri.parse("$api/api/barche/$barcaID"));
  }
}
