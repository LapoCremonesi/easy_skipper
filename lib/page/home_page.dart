import 'dart:convert';
import 'package:easy_skipper/constant.dart';
import 'package:easy_skipper/object/custom_agency.dart';
import 'package:easy_skipper/page/azienda_page.dart';
import 'package:easy_skipper/page/user_page.dart';
import 'package:easy_skipper/object/custom_profile.dart';
import 'package:easy_skipper/widget/homepage_box_view.dart';
import 'package:easy_skipper/widget/homepage_long_box_view.dart';
import 'package:easy_skipper/widget/homepage_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Map<String, bool> servizi = {
  "manutenzione": false,
  "trasporto": false,
  "pulizia": false,
  "gestione": false,
};

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.userProfile,
  });

  final CustomProfile userProfile;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isListView = widget.userProfile.isListView;
  late int j;
  List<CustomAgency> agenzie = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    j = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: verdeAcquaMarina,
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text("HomePage"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.userProfile.isAgency
                      ? const AziendaPage()
                      : UserPage(userProfile: widget.userProfile),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: blueCobalto,
              child: widget.userProfile.isAgency
                  ? const Center(
                      child: Icon(
                        Icons.business_rounded,
                        color: Colors.white,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: 60,
              width: width,
              margin: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.search),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ShowFilterOptions();
                        },
                      );
                    },
                    child: const Icon(Icons.filter_alt),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isListView = true;
                    });
                    await http.put(
                      Uri.parse(
                        "$api/profiles/${widget.userProfile.id}",
                      ),
                      headers: {
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode(
                        {
                          "data": {
                            "isListView": isListView,
                          },
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isListView ? Colors.red : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.view_list_rounded,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isListView = false;
                    });
                    await http.put(
                      Uri.parse(
                        "$api/profiles/${widget.userProfile.id}",
                      ),
                      headers: {
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode(
                        {
                          "data": {
                            "isListView": isListView,
                          },
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      color: !isListView ? Colors.red : Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 10, bottom: 10),
                    child: const Center(
                      child: Icon(
                        Icons.grid_3x3_rounded,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 300 *
                    ((height - 100 - 60 - 20 - 30 - 10 - statusBarHeight) /
                        300),
                child: ListView.builder(
                  itemCount: isListView
                      ? agenzie.length
                      : agenzie.length % 2 == 0
                          ? agenzie.length ~/ 2
                          : (agenzie.length + 1) ~/ 2,
                  itemBuilder: (context, index) {
                    j += 2;

                    if (isListView) {
                      return HomePageTileView(agency: agenzie[index]);
                    } else {
                      if (agenzie.length % 2 == 0) {
                        return Row(
                          children: [
                            HomePageBoxView(agency: agenzie[j - 2]),
                            HomePageBoxView(agency: agenzie[j - 1]),
                          ],
                        );
                      } else {
                        if (j - 1 == agenzie.length) {
                          return HomePageLongBoxView(agency: agenzie[j - 2]);
                        }
                        return Row(
                          children: [
                            HomePageBoxView(agency: agenzie[j - 2]),
                            HomePageBoxView(agency: agenzie[j - 1]),
                          ],
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    final response = await http.get(
      Uri.parse("$api/agencies?populate=*"),
    );

    final json = jsonDecode(response.body)["data"];

    for (int i = 0; i < json.length && i < 10; i++) {
      setState(() {
        agenzie.add(
          CustomAgency.fromJson(
            json[i],
          ),
        );
      });
    }
  }
}

class ShowFilterOptions extends StatefulWidget {
  const ShowFilterOptions({super.key});

  @override
  State<ShowFilterOptions> createState() => _ShowFilterOptionsState();
}

class _ShowFilterOptionsState extends State<ShowFilterOptions> {
  bool isManutenzioneSelected = false;
  bool isTrasportoSelected = false;
  bool isPuliziaSelected = false;
  bool isGestioneSelected = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Container(
        height: 500,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Serivizi",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Checkbox(
                value: isManutenzioneSelected,
                onChanged: (value) {
                  setState(() {
                    isManutenzioneSelected = value!;
                    servizi['manutenzione'] = isManutenzioneSelected;
                  });
                },
              ),
              title: const Text("Manutenzione"),
            ),
            ListTile(
              leading: Checkbox(
                value: isTrasportoSelected,
                onChanged: (value) {
                  setState(() {
                    isTrasportoSelected = value!;
                    servizi['trasporto'] = isTrasportoSelected;
                  });
                },
              ),
              title: const Text("Trasporto"),
            ),
            ListTile(
              leading: Checkbox(
                value: isPuliziaSelected,
                onChanged: (value) {
                  setState(() {
                    isPuliziaSelected = value!;
                    servizi['pulizia'] = isPuliziaSelected;
                  });
                },
              ),
              title: const Text("Pulizia"),
            ),
            ListTile(
              leading: Checkbox(
                value: isGestioneSelected,
                onChanged: (value) {
                  setState(() {
                    isGestioneSelected = value!;
                    servizi['gestione'] = isGestioneSelected;
                  });
                },
              ),
              title: const Text("Gestione"),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isManutenzioneSelected = false;
                      isTrasportoSelected = false;
                      isPuliziaSelected = false;
                      isGestioneSelected = false;
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.red,
                    ),
                    child: const Center(
                      child: Text(
                        "Pulisci",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60,
                    width: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: verdeAcquaMarina,
                    ),
                    child: const Center(
                      child: Text(
                        "Cerca",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
