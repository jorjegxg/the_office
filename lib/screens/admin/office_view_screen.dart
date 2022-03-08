import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_user.dart';
import 'package:the_office/widgets/user_list_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

class OfficeViewScreen extends StatefulWidget {
  const OfficeViewScreen({Key? key}) : super(key: key);

  @override
  State<OfficeViewScreen> createState() => _OfficeViewScreenState();
}

class _OfficeViewScreenState extends State<OfficeViewScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> office_list = [
    UserListWidget(
      nume: "1gg",
      imagine: "imagini/office.jpeg",
      id: 'sdrhgsrh',

      rol: "Amdin",
    ),
    UserListWidget(
      nume: "TACE",
      imagine: "imagini/office.jpeg",
      id: 'sdrhgsrh',
      rol: "Amdin",
    ),
  ];

  late Map<String, double> deskInfo = {
    "Free desks": birouriUtilizabile - birouriOcupate,
    "Ocupied desks": birouriOcupate,
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
        title: const Center(child: Text("Offices")),
        bottom: TabBar(
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
          Text("mama"),
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
                  imagine: "imagini/imagine.jpeg",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Building: Corp $cladire",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Floor number: $numarEtaj",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of desks: $numarBirouri",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of usable desks: $birouriUtilizabile",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of ocupied desks: $birouriOcupate",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Total free desks: ${birouriUtilizabile - birouriOcupate}",
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
          ),
        ],
      ),
    );
  }
}
