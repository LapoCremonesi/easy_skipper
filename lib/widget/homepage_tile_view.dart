import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:easy_skipper/page/azienda_info.dart';
import 'package:flutter/material.dart';

class HomePageTileView extends StatefulWidget {
  const HomePageTileView({
    super.key,
    required this.agency,
    required this.userProfile,
  });

  final CustomAgency agency;
  final CustomProfile userProfile;

  @override
  State<HomePageTileView> createState() => _HomePageTileViewState();
}

class _HomePageTileViewState extends State<HomePageTileView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AziendaInfo(userProfile: widget.userProfile, agency: widget.agency),
        ),
      ),
      child: Container(
        height: 90,
        width: width,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        child: Row(
          children: [
            widget.agency.image != ""
                ? Container(
                    height: 90,
                    width: width / 4 - 10,
                    decoration: BoxDecoration(
                      color: bluOceanoProfondo,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.agency.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Container(
                    height: 90,
                    width: width / 4 - 10,
                    decoration: const BoxDecoration(
                      color: bluOceanoProfondo,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: const Icon(Icons.business),
                  ),
            Container(
              height: 90,
              width: width - width / 4 - 10,
              decoration: const BoxDecoration(
                color: bluOceanoProfondo,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.agency.nome,
                            style: const TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 7),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.agency.indirizzo,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 25,
                      width: 30.0 * widget.agency.servizi.length,
                      margin: const EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.agency.servizi.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Service(
                              service: widget.agency.servizi[index]["servizio"],
                              height: 25,
                              width: 25,
                              size: 20,
                              padding: 3,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
