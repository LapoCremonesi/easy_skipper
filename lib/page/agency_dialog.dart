import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:flutter/material.dart';

class AgencyDialog extends StatefulWidget {
  const AgencyDialog({
    super.key,
    required this.userProfile,
    required this.agency,
  });

  final CustomProfile userProfile;
  final CustomAgency agency;

  @override
  State<AgencyDialog> createState() => _AgencyDialogState();
}

class _AgencyDialogState extends State<AgencyDialog> {
  late bool isListView = widget.userProfile.isListView;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 510,
        width: width - 20,
        child: Column(
          children: [
            Container(
              width: width - 20,
              height: 250,
              decoration: const BoxDecoration(
                color: bluOceanoProfondo,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 200,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: width - 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width - 20,
              height: 260,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text(
                            "Le mie Barche",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.directions_boat_filled_rounded,
                            size: 30,
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text(
                            "Aggiungi Barca",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 70,
                      width: width - 20,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: blueCieloChiaro,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Spacer(flex: 2),
                          Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.logout_outlined,
                            size: 30,
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
