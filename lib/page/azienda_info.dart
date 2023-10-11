import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:flutter/material.dart';

class AziendaInfo extends StatefulWidget {
  const AziendaInfo({
    super.key,
    required this.userProfile,
    required this.agency,
  });

  final CustomProfile userProfile;
  final CustomAgency agency;

  @override
  State<AziendaInfo> createState() => _AziendaInfoState();
}

class _AziendaInfoState extends State<AziendaInfo> {
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
                  color: bluOceanoProfondo,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '$api${widget.agency.mediumImage}',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: arancioneBoa,
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.only(
                          top: 10.0 + statusBarHeight,
                          left: 10,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                          ),
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
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  "Nome Azienda: ${widget.agency.nome}",
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 190, 189, 189),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  "Via Azienda: ${widget.agency.indirizzo}",
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Servizi",
              style: TextStyle(fontSize: 25),
            ),
            Container(
              height: 60,
              width: width,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.agency.servizi.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Service(
                      service: widget.agency.servizi[index]["servizio"],
                      height: 60,
                      width: 60,
                      size: 30,
                      padding: 10,
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
}
