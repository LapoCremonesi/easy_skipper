import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrenotazioniPage extends StatefulWidget {
  const PrenotazioniPage({super.key});

  @override
  State<PrenotazioniPage> createState() => PrenotazioniPageState();
}

class PrenotazioniPageState extends State<PrenotazioniPage> {
  final Future<CustomProfile> getData = Future.delayed(
    const Duration(milliseconds: 1),
    () async {
      final response = await http.get(
        Uri.parse('$api/api/get_profile?UID=${FirebaseAuth.instance.currentUser?.uid}'),
        headers: headers,
      );

      return CustomProfile.fromJson(jsonDecode(response.body));
    },
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            width: width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: verdeAcquaMarina,
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: statusBar + 10),
                  decoration: const BoxDecoration(
                    color: bluOceanoProfondo,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Prenotazioni',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: getData,
            builder: (BuildContext context, AsyncSnapshot<CustomProfile> snapshot) {
              List<Widget> children = [];

              if (snapshot.hasData) {
                children = [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: snapshot.data!.prenotazioni.length * 70.0,
                    width: width,
                    child: ListView.builder(
                      itemCount: snapshot.data!.prenotazioni.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: snapshot.data!.prenotazioni[index][0]['stato'] == "Pending"
                                ? Colors.grey
                                : snapshot.data!.prenotazioni[index][0]['stato'] == "Accept"
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          child: ListTile(
                            leading: Service(service: snapshot.data!.prenotazioni[index][0]['servizio'], height: 40, width: 40, size: 30, padding: 5),
                            title: Text(snapshot.data!.prenotazioni[index][0]['servizio']),
                            subtitle: Text(snapshot.data!.prenotazioni[index][0]['giorno']),
                            trailing: snapshot.data!.prenotazioni[index][0]['stato'] == "Pending"
                                ? const Icon(Icons.pending_rounded)
                                : snapshot.data!.prenotazioni[index][0]['stato'] == "Accept"
                                    ? const Icon(Icons.check)
                                    : const Icon(Icons.close),
                          ),
                        );
                      },
                    ),
                  ),
                ];
              }
              return Column(
                children: children,
              );
            },
          ),
        ],
      ),
    );
  }
}
