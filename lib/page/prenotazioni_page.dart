import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:flutter/material.dart';

class PrenotazioniPage extends StatefulWidget {
  const PrenotazioniPage({super.key, required this.profile});

  final CustomProfile profile;

  @override
  State<PrenotazioniPage> createState() => PrenotazioniPageState();
}

class PrenotazioniPageState extends State<PrenotazioniPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prenotazioni',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: widget.profile.prenotazioni.length * 60.0,
        width: width,
        child: ListView.builder(
          itemCount: widget.profile.prenotazioni.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.red,
              ),
              child: ListTile(
                leading: Service(service: widget.profile.prenotazioni[index]['servizio'], height: 40, width: 40, size: 30, padding: 5),
                title: Text(widget.profile.prenotazioni[index]['servizio']),
              ),
            );
          },
        ),
      ),
    );
  }
}
