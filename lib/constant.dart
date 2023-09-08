import 'package:flutter/material.dart';

const bluOceanoProfondo = Color(0xFF004080);
const blueCobalto = Color(0xFF0047AB);
const verdeAcquaMarina = Color(0xFF00A693);
const blueCieloChiaro = Color(0xFF87CEEB);
const arancioneBoa = Color(0xFFFFA500);

Future customDialog(BuildContext context, String title, String body) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  const Spacer(),
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      body,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                        right: 20,
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "OK",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -40,
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
    },
  );
}
