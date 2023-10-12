import 'package:flutter/material.dart';

class BottomCalendar extends StatefulWidget {
  const BottomCalendar({super.key});

  @override
  State<BottomCalendar> createState() => BottomCalendarState();
}

class BottomCalendarState extends State<BottomCalendar> {
  List<String> giorniSettimanaAbbreviati = [
    'Lun',
    'Mar',
    'Mer',
    'Gio',
    'Ven',
    'Sab',
    'Dom'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.70,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            width: width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Text('Mese'),
            ),
          ),
          Container(
            height: 20,
            width: width,
            color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: giorniSettimanaAbbreviati.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                  width: width / 7,
                  child: Center(
                    child: Text(giorniSettimanaAbbreviati[index]),
                  ),
                );
              },
            ),
          ),
          Container(
            height: (height * 0.75) - 167,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: 31,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('${index + 1}'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
