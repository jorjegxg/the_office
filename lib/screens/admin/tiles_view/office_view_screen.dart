import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/widgets/show_snack_bar.dart';
import 'package:the_office/widgets/tiles/user_list_widget.dart';
import 'package:pie_chart/pie_chart.dart';

class OfficeViewScreen extends StatefulWidget {
  const OfficeViewScreen(
      {Key? key,
      required this.id,
      required this.idBuilding,
      required this.buildingName,
        required this.officeName})
      : super(key: key);

  final String id;
  final String idBuilding;
  final String buildingName;
  final String officeName;


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

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _handleTabChange() {
    setState(() {});
  }

   showAlertDialog(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete ?"),
          content: Text("Are you sure you want to delete ? "),
          actions: <Widget>[
            MaterialButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text("Yes I am sure"),
              onPressed: () async {

                FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
                var ref = await _firebaseFirestore
                    .collection('Buildings')
                    .doc(widget.idBuilding)
                    .collection('Offices');

                var ref2 =  ref.doc(widget.id);
                var document = await ref2.get();
                var refList = await document['usersId'] as List<dynamic>;
                var emptyList = refList.isEmpty;

                ///todo verifica daca e vre-un user
                Navigator.of(context).pop();
                if(emptyList){
                  print("delete");
                  ref2.delete();
                  Navigator.of(ctx).pop();
                }else{
                  showSnackBar(ctx, "Office is not empty");
                }
              },
            ),
          ],
        );
      },
    );
  }

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Office ${widget.officeName}"),///todo adauga numele office-ului
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
          StreamBuilder(
              stream: _firebaseFirestore.collection('Buildings').doc(widget.idBuilding).collection('Offices').doc(widget.id).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: (snapshot.data!['usersId'] as List<dynamic>).map((newId) {
                      ///todo repara
                      return Text(newId);
                          // return UserListWidget(
                          //   nume: '${snapshot2.data['name']} ${snapshot2.data['lastName']}',
                          //   imagine: snapshot2.data['pictureUrl'],
                          //   rol: snapshot2.data['role'],
                          //   id: snapshot2.data['id'],
                          // );
                    }).toList(),
                  );
                }
              }),
          StreamBuilder(
              stream: _firestore
                  .collection('Buildings')
                  .doc(widget.idBuilding)
                  .collection('Offices')
                  .doc(widget.id)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                try{
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: SingleChildScrollView(
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
                              "Number of ocupied desks : ${snapshot.data['numberOfOccupiedDesks']} ",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Total free desks: ${snapshot.data['usableDeskCount'] - snapshot.data['numberOfOccupiedDesks']}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PieChart(
                              dataMap: {
                                "Free desks": (snapshot.data['usableDeskCount'] -
                                    snapshot.data['numberOfOccupiedDesks'])
                                    .toDouble(),
                                "Ocupied desks":
                                (snapshot.data['numberOfOccupiedDesks'])
                                    .toDouble(),
                              },
                              chartRadius: MediaQuery.of(context).size.width / 2,
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                                decimalPlaces: 0,
                              ),
                              animationDuration: Duration(seconds: 0),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RawMaterialButton(
                                  fillColor: Colors.blue[200],
                                  onPressed: () {},
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.4,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Edit office",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                RawMaterialButton(
                                  fillColor: Colors.blue[200],
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.4,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Delete office",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }catch(e){
                  print(e.toString());
                }
                return Text('State: ${snapshot.connectionState}');
              }),
        ],
      ),
    );
  }
}
