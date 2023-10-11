import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: height / 2 - 50,
            ),
            const Icon(
              Icons.wifi_off_rounded,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            const Text(
              'Nessuna connessione internet',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Text(
              'Aggiorna la pagina per riprovare',
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
