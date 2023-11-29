import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/widget/calendar.dart';
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
                            image: NetworkImage(widget.agency.image),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.agency.nome,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.agency.indirizzo,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const Spacer(),
            BottomCalendar(startDate: DateTime.now(), agency: widget.agency),
          ],
        ),
      ),
    );
  }
}
