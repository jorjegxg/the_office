import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_office/providers/role_provider.dart';
import 'package:the_office/screens/admin/create_screens/create_user.dart';
import 'package:the_office/screens/admin/update_office.dart';
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
  String officeName = "";
  int floorNumber = -1;
  int totalDeskCount = -1;
  int usableDeskCount = -1;
  int occupiedDeskCount = -1;
  String idAdmin = "";

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void getOfficeData() async {
    var ref = await _firebaseFirestore
        .collection("Buildings")
        .doc(widget.idBuilding)
        .collection("Offices")
        .doc(widget.id)
        .get();

    officeName = ref['name'];
    floorNumber = ref['floorsCount'];
    totalDeskCount = ref['totalDeskCount'];
    usableDeskCount = ref['usableDeskCount'];
    idAdmin = ref['idAdmin'];
    occupiedDeskCount = ref['numberOfOccupiedDesks'];
    //print(occupiedDeskCount);
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
                FirebaseFirestore _firebaseFirestore =
                    FirebaseFirestore.instance;
                var ref = await _firebaseFirestore
                    .collection('Buildings')
                    .doc(widget.idBuilding)
                    .collection('Offices');

                var ref2 = ref.doc(widget.id);
                var document = await ref2.get();
                var refList = await document['usersId'] as List<dynamic>;
                var emptyList = refList.isEmpty;

                ///todo verifica daca e vre-un user
                Navigator.of(context).pop();
                if (emptyList) {
                  print("delete");
                  ref2.delete();
                  Navigator.of(ctx).pop();
                } else {
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
    getOfficeData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Office ${widget.officeName}"),
        centerTitle: true,
        actions: [
          Provider.of<RoleProvider>(context).getRole() == "Administrator"
              ? IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UpdateOffice(
                        officeName: officeName,
                        floorNumber: floorNumber,
                        totalDeskCount: totalDeskCount,
                        usableDeskCount: usableDeskCount,
                        idAdmin: idAdmin,
                        idBuilding: widget.idBuilding,
                        idOffice: widget.id,
                        occupiedDeskCount: occupiedDeskCount,
                      );
                    }));
                  },
                  icon: Icon(Icons.edit))
              : Container()
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              child: Icon(
                Icons.view_list,
              ),
            ),
            Tab(
              child: Icon(Icons.info),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              StreamBuilder(
                  stream: _firebaseFirestore
                      .collection("Buildings")
                      .doc(widget.idBuilding)
                      .collection("Offices")
                      .doc(widget.id)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      idAdmin = snapshot.data['idAdmin'];

                      return StreamBuilder(
                          stream: _firebaseFirestore
                              .collection("Users")
                              .doc(idAdmin)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot2) {
                            if (!snapshot2.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot2.data['name'] != "No" &&
                                  snapshot2.data['lastName'] != "admin") {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Office administrator",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    UserListWidget(
                                      nume:
                                          '${snapshot2.data['name']} ${snapshot2.data['lastName']}',
                                      imagine: snapshot2.data['pictureUrl'],
                                      rol: snapshot2.data['role'],
                                      id: snapshot2.data['id'],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }
                          });
                    }
                  }),
              StreamBuilder(
                  stream: _firebaseFirestore
                      .collection('Buildings')
                      .doc(widget.idBuilding)
                      .collection('Offices')
                      .doc(widget.id)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ((snapshot.data!['usersId'] as List<dynamic>)
                                      .length !=
                                  0)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 5),
                                  child: Text(
                                    "Workers in the office :",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Nobody is working in this office",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                          Column(
                            children:
                                (snapshot.data!['usersId'] as List<dynamic>)
                                    .map((newId) {
                              return StreamBuilder(
                                  stream: _firebaseFirestore
                                      .collection("Users")
                                      .doc(newId)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot2) {
                                    if (!snapshot2.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return UserListWidget(
                                        nume:
                                            '${snapshot2.data['name']} ${snapshot2.data['lastName']}',
                                        imagine: snapshot2.data['pictureUrl'],
                                        rol: snapshot2.data['role'],
                                        id: snapshot2.data['id'],
                                      );
                                    }
                                  });
                              // return UserListWidget(
                              //   nume: '${snapshot2.data['name']} ${snapshot2.data['lastName']}',
                              //   imagine: snapshot2.data['pictureUrl'],
                              //   rol: snapshot2.data['role'],
                              //   id: snapshot2.data['id'],
                              // );
                            }).toList(),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
          StreamBuilder(
              stream: _firebaseFirestore
                  .collection('Buildings')
                  .doc(widget.idBuilding)
                  .collection('Offices')
                  .doc(widget.id)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                try {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    officeName = widget.officeName;
                    floorNumber = snapshot.data['floorsCount'];
                    totalDeskCount = snapshot.data['totalDeskCount'];
                    usableDeskCount = snapshot.data['usableDeskCount'];

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
                              "Floor number: ${floorNumber}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Number of desks: ${totalDeskCount}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Number of usable desks: ${usableDeskCount}",
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
                              "Total free desks: ${usableDeskCount - snapshot.data['numberOfOccupiedDesks']}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PieChart(
                              colorList: [
                                Color(0xff398AB9),
                                Colors.red,
                              ],
                              dataMap: {
                                "Free desks": (usableDeskCount -
                                        snapshot.data['numberOfOccupiedDesks'])
                                    .toDouble(),
                                "Ocupied desks":
                                    (snapshot.data['numberOfOccupiedDesks'])
                                        .toDouble(),
                              },
                              chartRadius:
                                  MediaQuery.of(context).size.width / 2,
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
                            Center(
                              child: RawMaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Color(0xff398AB9),
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
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  print(e.toString());
                }
                return Text('State: ${snapshot.connectionState}');
              }),
        ],
      ),
    );
  }
}
