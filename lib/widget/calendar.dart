import 'dart:convert';
import 'package:easy_skipper/calendar_const.dart';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/object/service.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BottomCalendar extends StatefulWidget {
  const BottomCalendar({
    super.key,
    required this.startDate,
    required this.agency,
  });

  final DateTime startDate;
  final CustomAgency agency;

  @override
  State<BottomCalendar> createState() => BottomCalendarState();
}

class BottomCalendarState extends State<BottomCalendar> {
  late PageController pageController;
  DateTime selectedDate = DateTime.now();
  late DateTime firstDayMonth = DateTime(widget.startDate.year, widget.startDate.month);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: DateTime.now().month - 1);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Column(
      children: [
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
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
                width: (MediaQuery.of(context).size.width - 20) / 7,
                child: Center(
                  child: Text(giorniSettimanaAbbreviati[index]),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height - 70 - 120 - 5 - 20 - 20 - 250 - statusBarHeight - 20,
          child: PageView.builder(
            controller: pageController,
            itemCount: 12,
            onPageChanged: (int index) {
              setState(() {
                firstDayMonth = DateTime(widget.startDate.year, index + 1);
                selectedDate = DateTime(selectedDate.year, index + 1, 1);
              });
            },
            itemBuilder: (context, index) {
              final month = DateTime(selectedDate.year, index + 1, 1);
              int day = 0;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                padding: const EdgeInsets.all(8.0),
                itemCount: getDaysInMonth(selectedDate) + DateTime(2023, month.month).weekday - 1,
                itemBuilder: (context, index) {
                  if (DateTime(selectedDate.year, selectedDate.month).weekday > index + 1) return const SizedBox();

                  day++;

                  if (firstDayMonth.month > widget.startDate.month) return giornoPrenotabile(DateTime(widget.startDate.year, selectedDate.month, day));
                  if (firstDayMonth.month == widget.startDate.month && day >= widget.startDate.day) return giornoPrenotabile(DateTime(widget.startDate.year, widget.startDate.month, day));
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 197, 197, 197),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text('$day'),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            const Spacer(),
            SizedBox(
              height: 100,
              width: 200,
              child: Center(
                child: Text(
                  nomeMesi[selectedDate.month - 1],
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
              },
              icon: const Icon(Icons.arrow_forward),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget giornoPrenotabile(DateTime giorno) {
    return GestureDetector(
      onTap: () {
        widget.agency.servizi.length == 1
            ? FancySnackbar.showSnackbar(
                context,
                titleWidget: const Text(
                  'Servizio prenotato con successo',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                message: '',
                onCloseEvent: () {},
              )
            : showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(
                      height: 110.0 * widget.agency.servizi.length + 39,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Text('Seleziona un servizio', style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: widget.agency.servizi.length * 110,
                            width: 300,
                            child: ListView.builder(
                              itemCount: widget.agency.servizi.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => addService(widget.agency.servizi[index]['servizio'], giorno),
                                      child: Container(
                                        height: 100,
                                        width: 300,
                                        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                        decoration: const BoxDecoration(
                                          color: arancioneBoa,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${widget.agency.servizi[index]['servizio']}', style: const TextStyle(fontSize: 25)),
                                            Service(service: widget.agency.servizi[index]['servizio'], height: 100, width: 100, size: 40, padding: 30),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text('${giorno.day}'),
        ),
      ),
    );
  }

  void addService(String service, DateTime giorno) async {
    await http.put(
      Uri.parse('$api/api/add_prenotazione'),
      body: jsonEncode(
        {
          'profile_UID': FirebaseAuth.instance.currentUser?.uid,
          'agency_UID': widget.agency.UID,
          'Prenotazione': [
            {
              'servizio': service,
              'giorno': giorno.toString(),
            }
          ]
        },
      ),
    );
  }
}
