import 'package:easy_skipper/calendar_const.dart';
import 'package:flutter/material.dart';

class BottomCalendar extends StatefulWidget {
  const BottomCalendar({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  State<BottomCalendar> createState() => BottomCalendarState();
}

class BottomCalendarState extends State<BottomCalendar> {
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
            child: Center(
              child: Text(
                nomeMesi[widget.startDate.month - 1],
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ),
          Container(
            height: 20,
            width: width,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: giorniSettimanaAbbreviati.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                  width: (width - 20) / 7,
                  child: Center(
                    child: Text(giorniSettimanaAbbreviati[index]),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: (height * 0.75) - 247,
            child: buildGrid(widget.startDate),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGrid(DateTime dateTime) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: getDaysInMonth(widget.startDate) + DateTime(2023, widget.startDate.month).weekday - 1,
      itemBuilder: (context, index) {
        if (DateTime(2023, widget.startDate.month).weekday > index + 1) return const SizedBox();

        /*if (firstDayMonth.isBefore(widget.startDate.subtract(const Duration(days: 1)))) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 197, 197, 197),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(''),
            ),
          );
        }*/
        return Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(''),
          ),
        );
      },
    );
  }
}
