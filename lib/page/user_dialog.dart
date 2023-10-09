import 'package:flutter/material.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({super.key});

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 580,
        width: width - 20,
        child: Column(
          children: [
            Container(
              width: width - 20,
              height: 250,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 201,
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
              height: 330,
              decoration: const BoxDecoration(
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
                        color: Colors.yellow,
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
                            Icons.directions_boat_filled_rounded,
                            size: 30,
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 70,
                    width: width - 20,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 70,
                    width: width - 20,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
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
                        color: Colors.yellow,
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
