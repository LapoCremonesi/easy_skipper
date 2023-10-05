import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:easy_skipper/page/azienda_info.dart';
import 'package:flutter/material.dart';

class HomePageBoxView extends StatefulWidget {
  const HomePageBoxView({
    super.key,
    required this.agency,
    required this.userProfile,
  });

  final CustomAgency agency;
  final CustomProfile userProfile;

  @override
  State<HomePageBoxView> createState() => _HomePageBoxViewState();
}

class _HomePageBoxViewState extends State<HomePageBoxView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AziendaInfo(
              userProfile: widget.userProfile, agency: widget.agency),
        ),
      ),
      child: Container(
        width: width / 2 - 20,
        height: 280,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bluOceanoProfondo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: bluOceanoProfondo,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.business_rounded,
                  size: 70,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              widget.agency.nome,
              style: const TextStyle(fontSize: 25),
            ),
            Text(widget.agency.indirizzo),
            const Spacer(),
            Container(
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
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
