import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/widgets/tiles/user_list_widget.dart';
import 'package:pie_chart/pie_chart.dart';

class OfficeViewScreen extends StatefulWidget {
  const OfficeViewScreen(
      {Key? key,
      required this.id,
      required this.idBuilding,
      required this.buildingName})
      : super(key: key);

  final String id;
  final String idBuilding;
  final String buildingName;

  @override
  State<OfficeViewScreen> createState() => _OfficeViewScreenState();
}

class _OfficeViewScreenState extends State<OfficeViewScreen>
    with TickerProviderStateMixin {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TabController _tabController;

  final List<Widget> office_list = [
    UserListWidget(
      nume: "1gg",
      imagine:
          "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8",
      id: 'sdrhgsrh',
      rol: "Amdin",
    ),
    UserListWidget(
      nume: "TACE",
      imagine:
          "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8",
      id: 'sdrhgsrh',
      rol: "Amdin",
    ),
  ];

  late Map<String, double> deskInfo = {
    "Free desks": 5,
    "Ocupied desks": 8,
  };

  final String cladire = "A";
  final double numarBirouri = 300;
  final double birouriUtilizabile = 100;
  final double birouriOcupate = 90;
  final int numarEtaj = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offices"),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Icon(
                Icons.dvr,
              ),
            ),
            Tab(
              child: Icon(
                Icons.view_list,
              ),
            ),
            Tab(child: Icon(Icons.info)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Text("REZOLVAAAAAAA"),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Administrator",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: UserListWidget(
                  nume: "1gg",
                  imagine:
                      "https://firebasestorage.googleapis.com/v0/b/the-office-ef23a.appspot.com/o/istockphoto-1177487069-612x612.jpg?alt=media&token=dd5bdcae-ca21-4dd3-81fc-8ffe90dfe2c8",
                  rol: "Amdin",
                  id: 'sdrhgsrh',
                ),
              ),
              const Text(
                "Employees",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 30),
                  child: ListView.builder(
                    itemCount: office_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return office_list[index];
                    },
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder(
              stream: _firestore
                  .collection('Buildings')
                  .doc(widget.idBuilding)
                  .collection('Offices')
                  .doc(widget.id)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Building: ${widget.buildingName}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Floor number: ${snapshot.data['floorsCount']}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Number of desks: ${snapshot.data['totalDeskCount']}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Number of usable desks: ${snapshot.data['usableDeskCount']}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Number of ocupied desks : 34 ",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Total free desks: birouriUtilizabile",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PieChart(
                            dataMap: deskInfo,
                            chartRadius: MediaQuery.of(context).size.width / 2,
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              decimalPlaces: 0,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Eroare"),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Building:",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Floor number:",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Number of desks:",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Number of usable desks:",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Number of ocupied desks :",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Total free desks:",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PieChart(
                          dataMap: deskInfo,
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 0,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  );
                }

                return Text('State: ${snapshot.connectionState}');
              }),
        ],
      ),
    );
  }
}
